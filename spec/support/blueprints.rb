require 'machinist'                                                  

DPovray::Task.blueprint() do
  project { 1000 }          
  povray_options { {'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> scene_file } }
  order { '0' }
  partial_image { nil }  
end

DPovray::Project.blueprint(:with_tasks) do
  name { 'yoquese' }
  id { 1000 }
  image { nil }                                                                                  
  povray_options { {'height'=>50, 'width'=>50, 'scene'=> scene_file } }    
  tasks { {'0'=> DPovray::Task.make(project: object.id, povray_options: object.povray_options)} }  
end

DPovray::Project.blueprint(:completed) do
  name { 'yoquese' }
  id { 1000 }
  image { nil }                                                                                  
  povray_options { {'height'=>50, 'width'=>50, 'scene'=> scene_file } }    
  tasks { {'0'=> DPovray::Task.make(partial_image: 'blabla', project: object.id, povray_options: object.povray_options)} }  
end             


DPovray::Project.blueprint() do              
  name { 'yoquese' }
  id { 1000 }
  image { nil }
  tasks { {} }
  povray_options { {'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> scene_file } } 
end

DPovray::Project.blueprint(:square) do              
  name { 'yoquese' }
  id { 1000 }
  image { nil }
  tasks { {} }
  povray_options { {'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> 'scene_file' } } 
end

DPovray::Project.blueprint(:rectangular_big_width) do              
  name { 'yoquese' }
  id { 1000 }
  image { nil }
  tasks { {} }
  povray_options { {'height'=>50, 'width'=>100, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> 'scene_file' } } 
end

DPovray::Project.blueprint(:rectangular_big_height) do              
  name { 'yoquese' }
  id { 1000 }
  image { nil }
  tasks { {} }
  povray_options { {'height'=>100, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> 'scene_file' } } 
end
