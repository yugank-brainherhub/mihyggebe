# frozen_string_literal: true

class API::V1::Document::SigningAction < Abstract::BaseAction

  TEMPLATE_NAME = 'provider_agreement'
  EMAIL_SUBJECT = 'Sign Provider Agreement via DocuSign'
  def perform
    if Rails.env.development?
      current_user.update(docusign_status: 'Completed')
      @success = true
      return true
    end  
    account_id = DEFAULTS[:docusign_id]

    base_path = DEFAULTS[:docusign_path]

    configuration = DocuSign_eSign::Configuration.new
    configuration.host = base_path
    api_client = DocuSign_eSign::ApiClient.new configuration
    bearer_token = generate_jwt_token(api_client)
    api_client.default_headers[:Authorization] = bearer_token

    template_id = retrieve_template(api_client)

    envelope_definition = make_envelope(template_id)

    envelopes_api = DocuSign_eSign::EnvelopesApi.new api_client
    envelopes_api.create_envelope account_id, envelope_definition

    current_user.update(docusign_status: 'Pending')
    @success = true
  rescue StandardError => e
    @success = false
    fail_with_error(422, '', error: I18n.t('docusign.error'))
  end

  def generate_jwt_token(api_client)
    integrator_key = DEFAULTS[:docusign_integration_key]
    user_id = DEFAULTS[:docusign_user_id]
    expires_in_seconds = 300  #5mins
    auth_server = DEFAULTS[:docusign_oauth_server]
    private_key_filename = 'data/docusign_private_key.txt'
    api_client.configure_jwt_authorization_flow(private_key_filename, auth_server,
                                                integrator_key, user_id, expires_in_seconds)
  end

  def retrieve_template(api_client)
    templates_api = DocuSign_eSign::TemplatesApi.new api_client
    options = DocuSign_eSign::ListTemplatesOptions.new
    options.search_text = TEMPLATE_NAME 
    results = templates_api.list_templates(DEFAULTS[:docusign_id], options)
    template_id = results.envelope_templates[0].template_id
    template_id
  end

  def make_envelope(template_id)
    envelope_definition = DocuSign_eSign::EnvelopeDefinition.new({
      :status => 'sent',
      :templateId => template_id,
      :emailSubject => EMAIL_SUBJECT
    })
    
    signer = DocuSign_eSign::TemplateRole.new({
      :email => current_user.email,
      :name => current_user.email,
      :roleName => 'signer'
    })
    envelope_definition.template_roles = [signer]
    envelope_definition
  end

  def data
    true
  end

  def authorize!
    true
  end
end
