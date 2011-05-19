module DPovray
  module Splitter
    
    def self.split_project_in_many_tasks(project)                                         
      project_with_task = project   
      max_line = project.povray_options['height']

      line = 0                    
      counter = 0
      while line < max_line.to_i do
        line_start = line+1
        line_end = line+10
        
        task = Task.new(project:project.id, order:counter.to_s, 
        povray_options:{
          'height'=>project.povray_options['height'], 
          'width'=>project.povray_options['width'], 
          'start_row'=>line_start, 
          'start_column'=>1, 
          'end_row'=>line_end, 
          'end_column'=>project.povray_options['width'],
          'scene'=>project.povray_options['scene']}
          )
        project_with_task.tasks[counter.to_s] = task
        line +=10
        counter +=1
      end      
      return project_with_task.tasks, project_with_task
    end  
  end
end