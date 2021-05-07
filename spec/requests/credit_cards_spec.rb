require 'swagger_helper'

RSpec.describe 'credit_cards', type: :request do

  path '/credit_cards' do

    get('list credit_cards') do
      tags 'Credit Cards'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::CreditCardIndexResponse.new

        schema expected_response_schema.schema.as_json

        before do |example|
          create(:credit_card)
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

    post('create credit_card') do
      let(:user) { create(:user) }

      tags 'Credit Cards'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::CreditCardCreateRequest.new

      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(201, 'successful') do
        expected_response_schema = SpecSchemas::CreditCardResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          {
            credit_card: {
              number: Faker::Finance.credit_card,
              expiration_date: Faker::Date.between(from: Date.today, to: 5.years.from_now).to_s,
              holder_name: Faker::Name.name,
              user_id: user.id
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
          { credit_card: { user_id: nil } }
        }

        run_test!
      end
    end
  end

  path '/credit_cards/{id}' do
    let(:credit_card) { create(:credit_card) }
    let(:id) { credit_card.id }

    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show credit_card') do
      tags 'Credit Cards'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::CreditCardResponse.new
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
