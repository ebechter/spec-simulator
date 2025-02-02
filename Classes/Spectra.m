classdef Spectra
    properties
        spectrum
        counts
        wavelength
        dsWavelength
        spectrumUnits
        rv
        scale
    end
    methods(Static)
        
        function [dsWavelength] = dopplerShift(wavelength,rv)
            % DESCRIPTION: Doppler shift a spectrum
            c = 2.9979245800 * 10^8;  % Speed of light [m/s] according to NIST - http://physics.nist.gov/cgi-bin/cuu/Value?c
            beta = rv / c;
            delta = sqrt((1 + beta) / (1 - beta));
            dsWavelength = [wavelength].*delta;
        end
        function [energy] = counts2Energy(wavelength,inputspectrum)
            l = wavelength*1E-6; %m
            c = 2.9979245800 * 10^8; %m/s
            h = 6.62607004E-34; %J*s
            engy = h*c./l;%energy of a photon in Joules
            energy = engy.*inputspectrum;
        end
        function [counts] = energy2Counts(spectrum, wavelength)
            l = wavelength*1E-6; %m
            c = 2.9979245800 * 10^8; %m/s
            h = 6.62607004E-34; %J*s
            engy = h*c./l;%energy of a photon in Joules
            
            counts = spectrum./engy;
        end
        function [wavelength] = vacShift(vac_wavelength)
            
            % # The IAU standard for conversion from air to vacuum wavelengths is given
            % # in Morton (1991, ApJS, 77, 119). For vacuum wavelengths (VAC) in
            % # Angstroms, convert to air wavelength (AIR) via:
            
            %The *10 assignment and then /10 is done because this formula
            %works in angs
            VAC = 10000*vac_wavelength;
            
            wavelength = (VAC./ (1.0 + 2.735182E-4 + 131.4182./VAC.^2 + 2.76249E8./VAC.^4))/10000;
            
        end
        
        function [flux] = fluxDenToflux(wavelength,fluxden)
                
            temp = diff(wavelength);
            dlam = [temp(1); temp];
            flux = fluxden.*dlam;     
        
        end
    end
end
