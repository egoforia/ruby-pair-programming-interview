require 'swagger_helper'

RSpec.describe 'accounts', type: :request do

  path '/accounts' do

    get('list accounts') do
      tags 'Accounts'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::AccountIndexResponse.new

        schema expected_response_schema.schema.as_json

        before do |example|
          create(:account)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        
        it_behaves_like "a JSON endpoint", 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { nil }
        end
      end
    end

    post('create account') do
      let(:user) { create(:user) }

      tags 'Accounts'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::AccountCreateRequest.new

      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::AccountResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          { account: { user_id: user.id } }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        
        it_behaves_like "a JSON endpoint", 201 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end
      end
    end
  end

  path '/accounts/{id}' do
    let(:account) { create(:account) }
    let(:id) { account.id }

    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show account') do
      tags 'Accounts'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::AccountResponse.new
        schema expected_response_schema.schema.as_json

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        
        it_behaves_like "a JSON endpoint", 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { nil }
        end
      end
    end
  end
end
