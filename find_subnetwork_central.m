function [ LN,RN ] = find_subnetwork_central( patient_coordinates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

%% Choose subnetworks based on name
LDL = patient_coordinates.LDL;
RDL = patient_coordinates.RDL;
indices_precentral_left   = find(strcmp(LDL,'precentral'));
indices_precentral_right  = find(strcmp(RDL,'precentral')) + 162;
indices_postcentral_left  = find(strcmp(LDL,'postcentral'));
indices_postcentral_right = find(strcmp(RDL,'postcentral')) + 162;


LN = [indices_precentral_left;indices_postcentral_left];
RN = [indices_precentral_right;indices_postcentral_right];

LN = sort(LN);
RN = sort(RN);
end

