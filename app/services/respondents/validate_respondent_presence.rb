class Respondents::ValidateRespondentPresence
  class RespondentNotPresent < StandardError
    def message
      'Respondent not found'
    end
  end

  def self.call(params)
    #dummy logic to simulate the validation process
    params_id = params[:id].to_i
    return true if params[:id] && params_id <= 20 && params[:type] == 'respondent_class'
    raise RespondentNotPresent
  end
end