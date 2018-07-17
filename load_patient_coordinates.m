function [ patient_coordinates ] = load_patient_coordinates( name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = name(1:9);

L = load([n '_sourcespace_324pts']);
L=struct2cell(L);
patient_coordinates.coords =L{1};

L = load([n '_sourcespace_desikan_labels']);
patient_coordinates.LDL = L.left_desikan_label;
patient_coordinates.RDL = L.right_desikan_label;

L = load([n '_source_in_lowerhalf']);
patient_coordinates.left_focus = [L.source_in_left_pos L.source_in_left_pre];
patient_coordinates.right_focus = [L.source_in_right_pos L.source_in_right_pre];

end

