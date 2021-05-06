require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users' do

    get('list users') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      
      response(200, 'successful') do
        expected_response_schema = SpecSchemas::UserIndexResponse.new

        schema expected_response_schema.schema.as_json

        before do |example|
          create(:user)
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

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::UserCreateRequest.new

      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(201, 'successful') do
        expected_response_schema = SpecSchemas::UserResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          { user: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name } }
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
          { user: { first_name: nil, last_name: nil } }
        }

        run_test!
      end
    end
  end

  path '/users/{id}' do
    let(:user) { create(:user) }
    let(:id) { user.id }
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::UserResponse.new
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

      # response(404, 'Not Found') do
      #   let(:id) { -1 } 

      #   run_test!
      # end
    end

    patch('update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::UserCreateRequest.new

      parameter name: :id, in: :path, type: :string, description: 'id'
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::UserResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          { user: { first_name: Faker::Name.last_name, last_name: Faker::Name.last_name } }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        
        it_behaves_like "a JSON endpoint", 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:params) { 
          { user: { first_name: nil, last_name: nil } }
        }

        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      expected_request_schema = SpecSchemas::UserCreateRequest.new

      parameter name: :id, in: :path, type: :string, description: 'id'
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      response(200, 'successful') do
        expected_response_schema = SpecSchemas::UserResponse.new
        schema expected_response_schema.schema.as_json

        let(:params) { 
          { user: { first_name: Faker::Name.last_name, last_name: Faker::Name.last_name } }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        
        it_behaves_like "a JSON endpoint", 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:params) { 
          { user: { first_name: nil, last_name: nil } }
        }

        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'id'

      response(204, 'successful') do
        it_behaves_like "a JSON endpoint", 204 do
          let(:expected_response_schema) { nil }
          let(:expected_request_schema) { nil }
        end
      end
    end
  end
end
