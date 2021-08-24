TOT = [length(find(data.B < 1)) length(find(test_data.B < 1));...
       length(find(data.B >= 141 & data.B <= 563)) length(find(test_data.B >= 141 & test_data.B <= 563));...
       length(find(data.B >= 750 & data.B <= 938)) length(find(test_data.B >= 750 & test_data.B <= 938));...
       length(find(data.B >= 1125 & data.B <= 1875)) length(find(test_data.B >= 1125 & test_data.B <= 1875));...
       length(find(data.B >= 2016 & data.B <= 2766)) length(find(test_data.B >= 2016 & test_data.B <= 2766));...
       length(find(data.B >= 3000 & data.B <= 3938)) length(find(test_data.B >= 3000 & test_data.B <= 3938));...
       length(find(data.B >= 4125 & data.B <= 4875)) length(find(test_data.B >= 4125 & test_data.B <= 4875));...
       length(find(data.B >= 5016 & data.B <= 6891)) length(find(test_data.B >= 5016 & test_data.B <= 6891));...
       length(find(data.B >= 7687 & data.B <= 9000)) length(find(test_data.B >= 7687 & test_data.B <= 9000));...
        ];
TOT(:,3) = sum(TOT(:,1:2),2);


%%
ub = unique(round(test_data.B));

TOT = zeros(length(ub),3);
for ij=1:length(ub)
   TOT(ij,1) = length(find(abs(round(data.B)-ub(ij)) <= 1)); 
   TOT(ij,2) = length(find(abs(round(test_data.B)-ub(ij)) <= 1)); 
end
TOT(:,3) = sum(TOT(:,1:2),2);


%%
total_provided = 0;
total_unprovided = 0;

deltas = unique([test_data.delta;data.delta]);
for ij=1:length(deltas)
   delt = deltas(ij);
   B = [data.B data.delta;test_data.B test_data.delta];
   disp(['Delta ' num2str(delt)]);
   ubv = unique(B(B(:,2) == delt,1));
   TAB = ubv;
   for ik=1:length(ubv)
      TAB(ik,2) = length(find(data.delta == delt & data.B == ubv(ik))); 
      TAB(ik,3) = length(find(test_data.delta == delt & test_data.B == ubv(ik))); 
   end
   disp(TAB)
end

%%
total_provided = 0;
total_unprovided = 0;
freqs = unique([test_data.freq;data.freq]);
for ij=1:length(freqs)
   freq = freqs(ij);
   B = [data.B data.freq;test_data.B test_data.freq];
   disp(['Freq ' num2str(freq)]);
   ubv = unique(B(B(:,2) == freq,1));
   TAB = ubv;
   for ik=1:length(ubv)
      TAB(ik,2) = length(find(data.freq == freq & data.B == ubv(ik))); 
      total_provided = total_provided + TAB(ik,2);
      TAB(ik,3) = length(find(test_data.freq == freq & test_data.B == ubv(ik))); 
      total_unprovided = total_unprovided + TAB(ik,3);
   end
   disp(TAB)
end
