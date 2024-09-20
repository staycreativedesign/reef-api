class ApplicationController < ActionController::API
  rescue_from NoMethodError, with: :internal_server_error_response
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveModel::UnknownAttributeError, with: :unknown_attribute_response
  rescue_from BlankObjectError, with: :object_is_blank_response
  rescue_from CustomErrorClass, with: :custom_error_response
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :parsing_error_response

  # 400 wrong route
  def route_not_found_response
    render json: {
      error: "Incorrect route please review api documentation"
    }, status: :bad_request
  end

  private

  # 200 but record is blank
  def object_is_blank_response(exception)
    render json: {
      info: "No records available, view POST api endpoint documentation for object creation."
    }
  end

  # 400 parsing error
  def parsing_error_response(exception)
    render json: {
      error: exception.message
    }, status: :bad_request
  end

  # 404
  def not_found_response(exception)
    render json: { error: "Record not found" },
      status: :not_found
  end

  # 422
  def unprocessable_entity_response(exception)
    render json: {
      error: exception.record.errors
    }, status: :unprocessable_entity
  end

  # 422 unknown attribute
  def unknown_attribute_response(exception)
    render json: {
      error: exception.message
    }, status: :unprocessable_entity
  end

  # 422 custom error
  def custom_error_response(exception)
    render json: {
      error: exception.message
    }, status: exception.status
  end

  # 500
  def internal_server_error_response(exception)
    render json: {
      error: "There was a problem, Reef has been notified and will contact you shortly."
    }, status: :internal_server_error
  end
end
