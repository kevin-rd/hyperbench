local case = testcase.new()
function case:Run()
    local ret = case.blockchain:Transfer({
        From = "00000be6819f41400225702d32d3dd23663dd690",
        To = "bfdde3c39f2223622e7dd7fa9fc3b02ec4b11653",
        Amount = 100,
        Extra = "11",
    })
    self.blockchain:Confirm(ret)
    return ret
end

return case
