# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/notes', type: :request do
  describe 'GET /index' do
    let!(:note) { create(:note) }

    it 'noteが取得できる' do
      get notes_path
      assert_response_schema_confirm
    end
  end

  describe 'POST /create' do
    subject(:post_request) { post notes_path, params: post_params }

    shared_examples 'エラーとなること' do
      it '422が返り、レコードが作成されないこと' do
        expect { post_request }.to\
          change(Note, :count).by(0).and\
            change(Tag, :count).by(0)
        expect(response.status).to eq 422
      end
    end

    context '正常入力のとき' do
      let(:post_params) { { tag: '食べ物', body: 'ラーメン食べたい' } }

      it '201が返り、レコードが作成されること' do
        expect { post_request }.to\
          change(Note, :count).by(1).and\
            change(Tag, :count).by(1)
        expect(response.status).to eq 201
      end

      context 'すでにtagが存在していたとき' do
        before { create(:tag, name: '食べ物') }

        it '201が返り、レコードが作成され、tagは追加されないこと' do
          expect { post_request }.to\
            change(Note, :count).by(1).and\
              change(Tag, :count).by(0)
          expect(response.status).to eq 201
        end
      end
    end

    context 'tagのパラメーターがないとき' do
      let(:post_params) { { body: 'ラーメン食べたい' } }

      include_examples 'エラーとなること'
    end

    context 'tagが空のとき' do
      let(:post_params) { { tag: '', body: 'ラーメン食べたい' } }

      include_examples 'エラーとなること'
    end

    context 'bodyのパラメーターがないとき' do
      let(:post_params) { { tag: '食べ物' } }

      include_examples 'エラーとなること'
    end

    context 'Nameが空のとき' do
      let(:post_params) { { tag: '食べ物', body: '' } }

      include_examples 'エラーとなること'
    end
  end
end
