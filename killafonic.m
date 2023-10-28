            function short = killafonic(long)
                %short = ['APF'; 'APF'; 'APF'; 'APF'; 'APF'];

                    if strcmp(long(1, :), 'All pass')
                        short = 'APF';
                    elseif strcmp(long(1, :), 'Low pass')
                        short = 'LPF';
                    elseif strcmp(long(1, :), 'High pass')
                        short = 'HPF';
                    elseif strcmp(long(1, :), 'Band pass')
                        short = 'BPF';
                    elseif strcmp(long(1, :), 'Stop band')
                        short = 'SBF';
                    elseif strcmp(long(1, :), 'Peaking EQ')
                        short = 'PEQ';
                    elseif strcmp(long(1, :), 'Low shelf')
                        short = 'LSF';
                    elseif strcmp(long(1, :), 'High shelf')
                        short = 'HSF';
                    else
                        short = 'APF';  
                    end

            end