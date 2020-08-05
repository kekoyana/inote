# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/v1/notes', type: :request do
  describe 'GET /index' do
    context 'tagパラメータがないとき' do
      let!(:tag1) { create(:tag, name: '食べ物') }
      let!(:tag2) { create(:tag, name: '旅行') }

      before do
        create(:note, tag: tag1, body: '冷やし中華')
        create(:note, tag: tag2, body: '北海道')
        get v1_notes_path
      end

      it 'noteが取得できる' do
        assert_response_schema_confirm
        expect(JSON.parse(response.body).dig('notes', 0, 'body')).to eq '冷やし中華'
      end
    end

    context 'tagがあるとき' do
      let!(:tag1) { create(:tag, name: '食べ物') }
      let!(:tag2) { create(:tag, name: '旅行') }

      before do
        create(:note, tag: tag1, body: '冷やし中華')
        create(:note, tag: tag2, body: '北海道')
        get v1_notes_path(tag: tag1.name)
      end

      it 'noteが取得できる' do
        assert_response_schema_confirm
        expect(JSON.parse(response.body).dig('notes', 0, 'body')).to eq '冷やし中華'
      end

      it '違うタグは取得できない' do
        expect(JSON.parse(response.body).dig('notes', 1, 'body')).to be_nil
      end
    end

    context '存在しないtagのとき' do
      before { get v1_notes_path(tag: 'dummy') }

      it '422が返ること' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'POST /create' do
    subject(:post_request) { post v1_notes_path, params: post_params }

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
