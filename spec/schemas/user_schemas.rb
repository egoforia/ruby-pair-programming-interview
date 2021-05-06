module SpecSchemas
  class UserIndexResponse
    include JSON::SchemaBuilder

    def schema
      array do
        items do
          object :user do
            number :id, required: true
            string :first_name, required: true
            string :last_name, required: true 
            string :created_at, required: true
            string :updated_at, required: true
          end
        end
      end
    end
  end

  class UserCreateRequest
    include JSON::SchemaBuilder

    def schema
      object do
        object :user do
          string :first_name, required: true
          string :last_name, required: true
        end
      end
    end
  end

  class UserResponse
    include JSON::SchemaBuilder

    def schema
      object do
        number :id, required: true
        string :first_name, required: true
        string :last_name, required: true
        string :created_at, required: true
        string :updated_at, required: true
      end
    end
  end
end