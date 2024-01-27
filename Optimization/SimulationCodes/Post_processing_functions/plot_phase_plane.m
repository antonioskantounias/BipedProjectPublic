function  plot_phase_plane(results,plot_results)
    %% Post process the results
    eventHS1 = generateEventAngularData('HS1', results);
    eventHS2 = generateEventAngularData('HS2', results);
    eventTO1 = generateEventAngularData('TO1', results);
    eventTO2 = generateEventAngularData('TO2', results);
    
    %% Plot the results
    if plot_results==1
        figure
        subplot(1,2,1)
        plot(results.thetaF,results.thetaF_d,'--')
        title('Hip angle phase space')
        xlabel('\theta_U')
        ylabel('\theta_Udot')
        hold on
        plot(results.thetaF(1),results.thetaF_d(1),'o')
        plot(eventHS1(:,1),eventHS1(:,2),'x')
        plot(eventTO1(:,1),eventTO1(:,2),'x')
        plot(eventHS2(:,1),eventHS2(:,2),'x')
        plot(eventTO2(:,1),eventTO2(:,2),'x')
        subplot(1,2,2)
        plot(results.thetaK,results.thetaK_d,'--')
        title('Knee angle phase space')
        xlabel('\theta_K')
        ylabel('\theta_Kdot')
        hold on
        plot(results.thetaK(1),results.thetaK_d(1),'o')
        plot(eventHS1(:,3),eventHS1(:,4),'x')
        plot(eventTO1(:,3),eventTO1(:,4),'x')
        plot(eventHS2(:,3),eventHS2(:,4),'x')
        plot(eventTO2(:,3),eventTO2(:,4),'x')
    end
end

function eventAngularData = generateEventAngularData(eventName, results)

numOfEvents         = results.events.occurancies.(eventName);
eventAngularData    = zeros(numOfEvents, 4);
for iEvent = 1:numOfEvents
    eventAngularData(iEvent, 1) = results.events.intermediates(iEvent).(eventName).thetaF;
    eventAngularData(iEvent, 2) = results.events.intermediates(iEvent).(eventName).thetaF_d;
    eventAngularData(iEvent, 3) = results.events.intermediates(iEvent).(eventName).thetaK;
    eventAngularData(iEvent, 4) = results.events.intermediates(iEvent).(eventName).thetaK_d;
end

end