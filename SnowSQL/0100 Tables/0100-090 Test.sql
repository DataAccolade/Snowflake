declare
    profit number(38, 2) default 0.0;

begin
    let cost number(38, 2) := 100.0;
    let revenue number(38, 2) default 110.0;

    cost := 50.0;

    profit := revenue - cost;
    return profit;
end;
