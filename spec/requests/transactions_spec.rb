require 'swagger_helper'

RSpec.describe 'transactions', type: :request do

  path '/transactions' do

    get('list transactions') do
      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::TransactionIndexResponse.new

        schema expected_response_schema.schema.as_json

        before do |example|
          create(:transfer_transaction)
          create(:credit_card_transaction)
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

    post('create transaction') do
      let(:from_account) { create(:account) }
      let(:to_account) { create(:account) }

      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::TransactionCreateRequest.new

      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(201, 'successful') do
        expected_response_schema = SpecSchemas::TransactionResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          {
            transaction: {
              from_account_id: from_account.id,
              to_account_id: to_account.id,
              transaction_type: 'transfer',
              amount: "10.0"
            }
          }
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

      response(422, 'Unprocessable Entity') do
        let(:params) { 
          { transaction: { amount: nil } }
        }

        run_test!
      end
    end
  end

  path '/transactions/{id}' do
    let(:transaction) { create(:transfer_transaction) }
    let(:id) { transaction.id }

    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show transaction') do
      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::TransactionResponse.new
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
