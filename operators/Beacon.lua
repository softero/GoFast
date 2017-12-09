local operator = {}

gofast = require("gofast")
book = require("book")

function operator.Init(params, context)
    operator.params = params
    operator.context = context
end

function operator.Start()
    book.SetInt("key", 0)
    gofast.Every("1s", function()
        book.SetInt("key", book.GetInt("key").value + 1)
    end)

    gofast.Async(function()
        local io = require("io")
        file = io.open("test.txt")
        count = 0
        for line in file:lines() do
            operator.context.Submit(0, {count, line})
            count = count + 1
        end
    end)
end

function operator.Process(tuple, context)
    --context.Submit(0, tuple)
    --context.Event("Event", {name="Event", firstValue=tuple[1]})
end

function operator.Stop()
end

return operator
