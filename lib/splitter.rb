module DPovray
  module Splitter
    
    def self.split_project_in_many_tasks(project)                 
      tasks = []                           
      project_with_task = project   
      max_line = project[:options][:height]

      line = 0                    
      counter = 0
      while line < max_line.to_i do
        line_start = line+1
        line_end = line+10
        task = {
          project:project[:id],
          order:counter, 
          partial_image:nil,          
          options:{
            height:project[:options][:height], 
            width:project[:options][:width], 
            start_row:line_start, 
            start_column:1, 
            end_row:line_end, 
            end_column:project[:options][:width],
            scene:project[:options][:scene]      
            }
          }
        tasks << task           
        project_with_task[:tasks][counter] = task
        line +=10
        counter +=1
      end      
      return tasks, project_with_task
    end  
  end
end