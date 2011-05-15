require 'resque'
require 'base64'
require 'date'

module DPovray    
  module Task
    @queue = :tasks
        
    def self.perform(task)
      
    end
  end
  
  module FinishedProject
    @queue = :finished_project

    def self.perform(params)
      puts 'Project succefully completed.'
    end
  end
end                         
