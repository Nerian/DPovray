module DPovray
  class Project
    extend Machinist::Machinable
    attr_accessor :name, :id, :image, :tasks, :povray_options
    
    def initialize(params={})
      @name = params[:name]
      @id = rand(10000)
      @image = nil
      @tasks = params[:tasks] || {}
      if params[:povray_options]
        @povray_options = params[:povray_options]
      else
        @povray_options = { 'height' => params[:height], 'width' => params[:width], 'scene' => params[:scene] }
      end
    end               
    
    def to_json(*a)
      {
        'json_class' => self.class.name,
        'data' => { 'name' => @name, 'id' => @id, 'image' => @image, 'tasks'=>@tasks, 'povray_options'=> @povray_options }
      }.to_json(*a)
    end           
    
    def self.json_create(o)
      new(name: o['data']['name'], id: o['data']['id'], image: o['data']['image'], tasks:o['data']['tasks'], povray_options: o['data']['povray_options'])
    end
    
    def self.completed?(project)    
      project['tasks'].all? { |task| task['partial_image'] }  
    end
  end    
end