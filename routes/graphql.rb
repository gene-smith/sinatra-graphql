require "json"
require_relative "../graph/application_schema"

module TodoApp
  module Routes
    class Graphql < Sinatra::Application
      post "/graphql" do
        query_string = params[:query]
        query_variables = ensure_hash(params[:variables])
        result = ApplicationSchema.execute(
          query_string,
          variables: query_variables,
          context: {}
        )
        render json: result
      end

      private

      def ensure_hash(query_variables)
        if query_variables.blank? || query_variables == "null"
          {}
        elsif query_variables.is_a?(String)
          JSON.parse(query_variables)
        else
          query_variables
        end
      end
    end
  end
end
