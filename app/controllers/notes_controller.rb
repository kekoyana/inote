# frozen_string_literal: true

class NotesController < ApplicationController
  # GET /notes
  def index
    @notes = Note.all
    render formats: :json
  end

  # POST /notes
  def create
    if Note.create_by(tag: post_params[:tag], body: post_params[:body])
      render status: 201, json: { status: :ok }
    else
      render status: 422, json: { status: :error }
    end
  end

  private

  def post_params
    params.permit(:tag, :body)
  end
end
