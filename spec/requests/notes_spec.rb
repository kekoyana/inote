# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/notes', type: :request do
  let(:valid_params) do
    {
      tag: 'あさごはん',
      note: 'コーンフレークをたべた',
    }
  end

  let(:invalid_params) do
    {
      tag: ' ',
      note: 'ラーメンをたべた',
    }
  end

  describe 'GET /index' do
    let!(:note) { create(:note) }

    it 'noteが取得できる' do
      get notes_path
      assert_response_schema_confirm
    end
  end

  xdescribe 'POST /create' do
    context '正常入力のとき' do
      it 'Noteが作成される' do
        expect do
          post notes_path, params: valid_params
        end.to change(Note, :count).by(1)
      end
    end

    context '以上値の入力のとき' do
      it 'Noteが作成されない' do
        expect do
          post notes_path, params: invalid_params
        end.to change(Note, :count).by(0)
      end
    end
  end
end
