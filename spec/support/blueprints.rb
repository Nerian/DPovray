require 'machinist'                                                  

DPovray::Task.blueprint() do
  project { 1000 }          
  povray_options { {'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> scene_file } }
  order { '0' }
  partial_image { nil }  
end
