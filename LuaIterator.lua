local iterator = function(from, to)
    local i = from 
    return function()
        i = i - 1
        if i < to then return end
        return i, 4, 3
    end
end

for a, b, c in iterator(10, 3) do
    print(a)
    print(b)
    print(c)
end
