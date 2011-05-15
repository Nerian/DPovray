module DPovray
  module Splitter
    
    def self.split_project_in_many_tasks(project)                 
      tasks = []          

      max_line = project[:options][:height]

      line = 0
      while line < max_line do
        line_start = line+1
        line_end = line+10                                                                                                    
        tasks << {
          project:1000,           
          options:{
            height:project[:options][:height], 
            width:project[:options][:width], 
            start_row:line_start, 
            start_column:0, 
            end_row:line_end, 
            end_column:project[:options][:width],
            scene:project[:options][:scene]      
            }
          }
        line +=10
      end
      tasks
            
    end
  
  end
end