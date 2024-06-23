function a = get_index(a_index, a_length)
    % Initialize the sequence with the first value
    a = [1];

    % Check if the length of the sequence is at least 2
    if a_length < 2
        a = a(1:a_length); % If not, truncate or return the array as is
        return;
    end

    % Increment with a step size of 2, 'a_index' number of times
    current = 1;
    for i = 1:a_index-1
        current = current + 2;
        a(end+1) = current;
    end

    % Continue incrementing with a step size of 1
    while a(end) < a_length
        current = current + 1;
        a(end+1) = current;
    end

end
