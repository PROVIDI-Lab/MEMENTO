% Code used for the preparation and evaluation of the MEMENTO challenge
% organized by Kurt Schilling, Andrada Ianus and Alberto De Luca
% Code author: Alberto De Luca (a.deluca-2@umcutrecht.nl)
% Visualize the unprovided data vs predicted plot
function ISBI_Subchallenge1_VisualEvaluation(unprovided_data)
    figure
    for subplot_id=1:size(unprovided_data.GroundTrueValues,2)
       subplot(size(unprovided_data.GroundTrueValues,2),1,subplot_id);
       plot(unprovided_data.GroundTrueValues(:,subplot_id),'.b');
       hold on
       plot(unprovided_data.Signal(:,subplot_id),'-r');
       hold off
       title(['Signal ' num2str(subplot_id)]);
    end
end