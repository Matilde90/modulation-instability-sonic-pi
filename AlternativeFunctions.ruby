##
# Legacy:
# Case switch to readjust amplitude
# This has been now substituted with Auro's better gaussian function
##
def get_adjusted_amp(amp)
    max = 5;
    mid = filter + (max - filter) / 2;
    low = filter + (mid - filter) / 2;
    upper_mid = mid + (max - mid) / 2;
    # map between amplitude and sound to play
    # needed as sonic pi accepts only values between 0.01 and 1
    case amp
    when upper_mid..max
    adjustedAmp = 1
    when mid..upper_mid
    adjustedAmp = 0.7
    when low..mid
    adjustedAmp = 0.4
    when filter..low
    adjustedAmp = 0.1
    else
    adjustedAmp = amp
    end
end