class Api::V1::CardsController < API::V1::ApplicationController

  # DELETE /api/cards/:id
  def destroy
    begin
      Stripe::Customer.delete_source(
        current_user.stripeID,
        params[:id]
      )
      head :ok
    rescue StandardError => e
      head :unprocessiable_entity
    end
  end
end
