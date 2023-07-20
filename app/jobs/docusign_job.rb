# frozen_string_literal: true

class DocusignJob < ApplicationJob
  queue_as :default

  def perform(h, user_id)
    val = h['DocuSignEnvelopeInformation']['EnvelopeStatus']['Status']
    if completed?(val)
      User.find(user_id).update(docusign_status: val)
    else
      User.find(user_id).update(docusign_status: '')
    end
  end

  def completed?(val)
    val == 'Completed'
  end
end
