class Agents::ValidateAgentPresence
  class AgentNotPresent < StandardError
    def message
      'Object not found'
    end
  end

  def self.call(params)
    #dummy logic to simulate the validation process
    params_id = params[:id].to_i
    return true if params[:id] && params_id <= 20 && params[:type] == 'object_class'
    raise AgentNotPresent
  end
end