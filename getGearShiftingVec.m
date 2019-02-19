%% gearVec= getGearShiftingVec(V)
% GETGEARSHIFTINGVEC        Returns a vector of gears corresponding to the
%                           velocity vector 'V'. The gear shifting strategy
%                           is based on visual examination of the the
%                           NEDC_MAN gear-shifting strategy.
%
%
%
%   Input:      'V'         - Input driving cycle vector containing
%                             velocity
%
%   Output:     'gearVec'   - The corresponding gears to the velocity
%                             vector V
%
%   Author: Peter Nyberg
%   Created: 2013-10-23
%   Last modifed: 19th Sept 2014
%   Note: Modified by Mark Ng to accommodate 8 speed gearbox

function gearVec = getGearShiftingVec( V )

% Conversion unit from m/s to km/h
mps2kph = 3.6;

% Speed kph/1000rpm for each gear
speed = [8.07 14 21.7 29 34.7 42.3 52.34 62.9] .* [2.8 2.7 2.6 2.4 2.2 2 1.8 1.6];

% Strategy extracted from visual examination of the V_z (speed) and G_z
% (gears) of the NEDC_MAN driving cycle
gearVec = zeros( length( V ),1 );
indFirstGear   = find( 0 < V * mps2kph & V * mps2kph <= speed(1) );
indSecondGear  = find( V * mps2kph > speed(1) & V * mps2kph <= speed(2) );
indThirdGear   = find( V * mps2kph > speed(2) & V * mps2kph <= speed(3) );
indFourthGear  = find( V * mps2kph > speed(3) & V * mps2kph <= speed(4) );
indFifthGear   = find( V * mps2kph > speed(4) & V * mps2kph <= speed(5) );
indSixthGear   = find( V * mps2kph > speed(5) & V * mps2kph <= speed(6) );
indSeventhGear = find( V * mps2kph > speed(6) & V * mps2kph <= speed(7) );
indEighthGear  = find( V * mps2kph > speed(7) );

% Set the corresponding gear number from the strategy
gearVec(indFirstGear)   = 1;
gearVec(indSecondGear)  = 2;
gearVec(indThirdGear)   = 3;
gearVec(indFourthGear)  = 4;
gearVec(indFifthGear)   = 5;
gearVec(indSixthGear)   = 6;
gearVec(indSeventhGear) = 7;
gearVec(indEighthGear)  = 8;

%tempGearVec = gearVec;

% With a hysterisis-compensation
for ii = 2:1:length( gearVec )
    if gearVec(ii-1) > gearVec(ii) % gear-change have been taken place
        switch gearVec(ii)
            case 1
                if V(ii) * mps2kph > speed(1) - 2
                    gearVec(ii) = 2;
                end
            case 2
                if V(ii) * mps2kph > speed(2) - 2
                    gearVec(ii) = 3;
                end
            case 3
                if V(ii) * mps2kph > speed(3) - 2
                    gearVec(ii) = 4;
                end
            case 4
                if V(ii) * mps2kph > speed(4) - 2
                    gearVec(ii) = 5;
                end
            case 5
                if V(ii) * mps2kph > speed(5) - 2
                    gearVec(ii) = 6;
                end
            case 6
                if V(ii) * mps2kph > speed(6) - 2
                    gearVec(ii) = 7;
                end
            case 7
                if V(ii) * mps2kph > speed(7) - 2
                    gearVec(ii) = 8;
                end
            otherwise
                % do nothing
        end
    end
end

% Do not change gear for just 1 time instant and then back again 6/2-14
for kk = 2:1:length( gearVec ) - 1
    if gearVec(kk - 1) ~= gearVec(kk) && gearVec(kk - 1) == gearVec(kk + 1)
        gearVec(kk) = gearVec(kk - 1);
    end
end

%gearVec = tempGearVec;

end
