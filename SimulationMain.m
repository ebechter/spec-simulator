% Simulation Main Script



% First thing is to check user inputs from the wrapping script.

% Create initial instances of classes (objects)

% mode 2 (SES) part of simulation






% 
% for ii = tracenum
%         
%         
%         trace{1} = curve{1};
%         trace{2} = curve{2};
%         trace{3} = curve{1};
%         
%     end
    
    
    
    
    
    
    
    
    
    
    
    
%     
% end
% 
% 
% Spectroscopy Modes
% 
% I want mode x and traces (default all 3)  [ 1 -> 3]
% 
% mode 1
% 
% full star -> detector
% 
% mode 2
% 
% etalon -> calibration throughput -> spectrograph
% 
% mode 3
% 
% flat
% 
% 
% 
% 
% 
% 
% Operation for traces [1 -> 3]
% 
% trace{1} = curve 1: typical star thing
% 
% trace{2} = curve 2: typical etalon
% 
% trace{3} = curve 1: repeat star
% 
% 
% 
% 
% curve 1:
% 
% atmosphere? yes/no
% throughput? yes/no
% 
% source: star, atmosphere: yes ; throughputs: telescope, lbti, acquisition_camera, spectrograph
% 
% 
% 
% 
% 
% 
% 
% mode 2:
% 
% sources: star, etalon, star
% 
% atmosphere: yes, no, yes
% 
% throughputs: telescope, lbti, acquisition_camera, spectrograph ; calibration; telescope, lbti, acquisition_camera, spectrograph
% 
% mode 3:
% 
% sources: etalon, etalon, etalon
% 
% atmosphere: no, no, no
% 
% throughputs: calibration, calibration, calibration
% 
% 
% mode 4:
% 
% sources: flat, flat, flat
% 
% atmosphere: no, no, no
% 
% throughputs: calibration, calibration, calibration



curve{1}.source = 'Star';
curve{1}.atmosphere = 1;
curve{1}.throughput = {'lbt','lbti','acquisition_camera','fiber','spectrograph'};

curve{2}.source = 'Etalon';
curve{2}.atmosphere = 0;
curve{2}.throughput = {'calibration','spectrograph'};

curve{3} = curve{1};



%========== Instanciate objects ===========%
tracenum = [1,2,3];
tracenum = 1
for ii = tracenum
    
    %========== Source Options ===========%
    
    if strcmp('Etalon', curve{ii}.source) == 1 && exist('etalon','var') == 0
        % make an etalon
        etalon = Etalon();
        
    elseif strcmp('Star', curve{ii}.source) == 1 && exist('star','var') == 0
        % make a star
        star = Star();
        
    elseif strcmp('Flat', curve{ii}.source) == 1 && exist('flat','var') == 0
        % make a flat spectrum
        flat = Flat();
    end
    
    %========== Atmosphere Options ===========%
    
    if curve{ii}.atmosphere == 1 && exist('atmosphere','var') == 0
        atmosphere = Atmosphere();
    end
    
    %========== Throughput Options ===========%
    components =[];
    
    if nonzeros(strcmp('spectrograph', curve{ii}.throughput)) == 1 && exist('spectrograph','var') == 0
        % make the spectrograph throughput
        spectrograph = Spectrograph();
        
    end
    
    if nonzeros(strcmp('lbt', curve{ii}.throughput)) == 1 && exist('lbt','var') == 0
        % make the spectrograph throughput
        lbt = Imager('LBT');
        components = [components, lbt];
        
    end
    
    if nonzeros(strcmp('lbti', curve{ii}.throughput)) == 1 && exist('lbti','var') == 0
        % make the spectrograph throughput
        lbti = Imager('LBTI');
        components = [components, lbti];
    end
end

% 
% % Pass instrument names to simulation class
% 
% % one or fewer of source, final throughput, atmosphere, 
% [combinedthroughput] = Simulation.CombineImagerThroughput()
% 

 [finalThroughput] = combinedImagerThroughput (objects);
 comTput = objects{1}.finalThroughput;
 
 for ii = 2:number of objects %loop over cellarry size (i.e. surfaces)
     comTput = objects{1}.finalThroughput;
     [comTput{ii}(:,1),comTput{ii}(:,2)] = Instrument.multiply_curves(comTput{ii-1}(:,1),comTput{ii-1}(:,2),comTput{ii}(:,1),comTput{ii}(:,2));    
 end



% 
% if exist('atmosphere','var')
%     [addedatmosphere] = Simulation.AddAtmosphere(star,atmosphere);
%     
% else
%     
%     addedatmosphere = star;
% end
% 
% [modifiedspectrum] = Simulation.MultiplyThroughput(addedatmosphere, combinedthroughput);
% 
% if exist('spectrgraph','var')
%     [modifiedspectrum] = Simulation.MultiplyThroughput(addedatmosphere, combinedthroughput);
% end
% 


% Pass them to the Simulation class

% simulation class








