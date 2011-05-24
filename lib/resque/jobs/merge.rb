module Resque    
  module Merge
    
    def self.perform(project_id)
      redi = Redis.new                                             
      
      hash_OrderImage = redi.hgetall('resque:dpovray:images-for-project:'+project_id.to_s)      
      
      final_image = Resque::Merger.merge_partial_images_from_tasks(hash_OrderImage)
      
      project = JSON.parse(redi.hget('active_projects', project_id))
      project.image = final_image
      redi.hset('active_projects', project.id, project.to_json)                
    end
  end
end