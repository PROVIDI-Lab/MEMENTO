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