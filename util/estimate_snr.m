
function snr_db = estimate_snr(volume)
    % estimate_snr: Estimates the SNR in dB of a 3D medical volume.

    % Create the object mask
    threshold = 0.1 * max(volume, [], 'all');
    object_mask = volume > threshold;

    % Calculate signal power
    signal = volume(object_mask);
    signal_power = mean(signal.^2);

    % Calculate noise power
    noise = volume(~object_mask);
    noise_power = mean(noise.^2);

    % Calculate SNR in dB
    snr_db = 10 * log10(signal_power / noise_power);
end