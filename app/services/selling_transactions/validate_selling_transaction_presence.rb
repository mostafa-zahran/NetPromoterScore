class SellingTransactions::ValidateSellingTransactionPresence
  class SellingTransactionNotPresent < StandardError
    def message
      'Selling Transaction not found'
    end
  end

  def self.call(params)
    #dummy logic to simulate the validation process
    return true if respondent_valid?(params) && agent_valid?(params) && params[:touchpoint].present?
    raise SellingTransactionNotPresent
  end

  def self.respondent_valid?(params)
    params_respondent_id = params[:respondent_id].to_i
    params[:respondent_id] && params_respondent_id <= 20 && params[:respondent_class] == 'respondent_class'
  end

  def self.agent_valid?(params)
    params_object_id = params[:object_id].to_i
    params[:object_id] && params_object_id <= 20 && params[:object_class] == 'object_class'
  end
end