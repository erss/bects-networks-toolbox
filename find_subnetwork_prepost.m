function [ PreN,PostN ] = find_subnetwork_prepost( patient_coordinates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

%% Choose subnetworks based on name
LDL = patient_coordinates.LDL;
RDL = patient_coordinates.RDL;
hand = patient_coordinates.hand;
if strcmp(hand,'right')
    PreN   = find(strcmp(LDL,'precentral'));
    PostN  = find(strcmp(LDL,'postcentral'));
end

if strcmp(hand,'left')
    PreN  = find(strcmp(RDL,'precentral')) + 162;
    PostN= find(strcmp(RDL,'postcentral')) + 162;
end

PreN = sort(PreN);
PostN = sort(PostN);
end

