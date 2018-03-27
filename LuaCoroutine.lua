-- require("socket")
-- function sleep(n)
--     socket.select(nil, nil, n)
-- end

local function taskA(callback, ...)
    -- new thread to do it
    -- sleep(1)
    callback(nil, nil)
end

local function taskB(callback, ...)
    -- new thread to do it
    -- sleep(0.5)
    callback(nil, nil)
end


-- 首次执行协程co时，参数Val1...会传递给协程co的函数；
-- 再次执行协程co时，参数Val1...会作为给协程co中上一次yeild的返回值。
function runAsyncFunc(func, ...)
    local current = coroutine.running()
    func(function(err, msg)
        local current = coroutine.running()
        coroutine.resume(current)
    end, ...)
    coroutine.yield()
end

local co = coroutine.create(function()
    runAsyncFunc(taskA, "helloA")
    runAsyncFunc(taskB, "helloB")
end)

coroutine.resume(co)

local co1 = coroutine.create(function()
    runAsyncFunc(taskA, "helloA1")
    runAsyncFunc(taskB, "helloB1")
end)
coroutine.resume(co1)
