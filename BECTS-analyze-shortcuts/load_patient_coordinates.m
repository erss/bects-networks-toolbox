function [ patient_coordinates ] = load_patient_coordinates(DATAPATH, source_session )
% Creates patient_coordinates structure.  If doesn't exist already, creates
% using all files, if already exists in folder, loads information
%
% INPUTS:
%   DATAPATH      = Path to directory of patient,
%                   example: '~/Desktop/bects_data/pBECTS001'
%  source_session = Name of file containing coordinate information.
%
% OUTPUT:
%  patient_coordinates is a structure containing fields:
%
%  name   = patient name
%
%  coords = [5 x 324] First row contains 1 = left hemisphere, 2 = right
%  hemisphere; Second row contains vertex indices; Third - Fifth rows
%  contain xyz coordinates
%
%  LDL, RDL = Desikan labels of each vertex (Left and right hemispheres
%  respectively)
%
%  left_focus, right_focus = Vertex indices for the seizure onset zone in
%  the left and right hemispheres respectively.
%
%
%  Questions: (1) do I include hand, spiking hemisphere, status ...?
%             (2) xyz are the same for each sesssion
if exist([DATAPATH '/patient_coordinates.mat'],'file') ~=2
    load([DATAPATH '/' source_session(1:9) '_source_in_lowerhalf']);
    load([DATAPATH '/sleep_source/' source_session]);
    
    patient_coordinates.name   = source_session(1:9);
    patient_coordinates.coords = [[ones(1,162); ico_2_source_points_coordinates_left'], ...
        [2*ones(1,162); ico_2_source_points_coordinates_right']];
    
    patient_coordinates.LDL    = ico_2_source_points_labels_left;
    patient_coordinates.RDL    = ico_2_source_points_labels_right;
    
    patient_coordinates.left_focus  = [source_in_left_pos source_in_left_pre];
    patient_coordinates.right_focus = [source_in_right_pos source_in_right_pre];
    
    save([DATAPATH '/patient_coordinates.mat'],'patient_coordinates')
    
else
    load([DATAPATH '/patient_coordinates']);
end

end

