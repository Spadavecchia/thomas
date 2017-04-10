defmodule Chap08Test do
  use ExUnit.Case, async: true
  import Chap08

  test "map" do
    tool = %{language: "Clojure", type: "Functional", pleasure: "High"}
    assert Map.keys(tool) == [:language, :pleasure, :type]
    assert Map.values(tool) == ["Clojure", "High", "Functional"]
    assert tool[:language] == "Clojure"
    assert tool.language == "Clojure"
    tool1 = Map.drop(tool, [:language, :pleasure])
    assert tool1 == %{type: "Functional"}
    tool2 = Map.put tool1, :equivalent, "Elixir"
    assert tool2 == %{type: "Functional", equivalent: "Elixir"}
    refute Map.has_key?(tool, :equivalent)
    {equivalent, tool3} = Map.pop(tool2, :equivalent)
    assert Map.equal? tool3, tool1
    assert equivalent == "Elixir"
  end

  test "pattern matching with maps" do
    person = %{name: "Tony", height: 1.88}
    %{name: a_name} = person
    assert a_name == "Tony"
    assert catch_error(%{fail: _fail} = person) == {:badmatch, person}
    assert %{name: "Tony"} = person
    assert catch_error(%{name: "Tony Tiger"} = person) == {:badmatch, person}
  end

  test "pattern matching on list comprehension" do
    people = [
      %{name: "Grumpy", height: 1.24},
      %{name: "Tony", height: 1.88},
      %{name: "Dopey", height: 1.32},
      %{name: "Shaquille", height: 2.16},
      %{name: "Sneezy", height: 1.24}
    ]
    talls = for person = %{height: height} <- people, height > 1.80, do: person
    assert talls == [%{name: "Tony", height: 1.88},
                     %{name: "Shaquille", height: 2.16}]

    observations = people |> Enum.map(&book/1)
    assert observations == [
      "Need low shower controls for Grumpy",
      "Need regular bed for Tony",
      "Need regular bed for Dopey",
      "Need extra long bed for Shaquille",
      "Need low shower controls for Sneezy",
    ]
  end

  test "matching variable keys" do
    data = %{name: "Tony", state: "DF", likes: "Clojure"}
    values = for key <- [ :name, :likes ] do
      %{ ^key => value } = data
      value
    end
    assert values == ["Tony", "Clojure"]
  end

  test "updating a map" do
    original = %{language: "Clojure", type: "Functional", pleasure: "High"}
    updated = %{ original | language: "Ruby", type: "OOP", pleasure: "Low" }
    assert updated == %{language: "Ruby", type: "OOP", pleasure: "Low"}
    enhanced = Map.put_new(original, :add, "Data")
    assert enhanced == %{language: "Clojure", add: "Data",
                         type: "Functional", pleasure: "High"}
  end

  test "structs" do
    s1 = %Subscriber{}
    refute s1.paid
    assert s1.over_18
    s2 = %Subscriber{name: "Tony"}
    assert s2.name == "Tony"
    %Subscriber{name: a_name} = s2
    assert s2.name == a_name
    updated = %Subscriber{s2 | paid: true}
    assert updated == %Subscriber{name: a_name, paid: true}

    assert Subscriber.may_attend_after_party(updated)
    refute Subscriber.may_attend_after_party(s2)
  end

  test "nested structs" do
    report = %BugReport{owner: %Customer{name: "Tony", company: "Dnaritag"},
                       details: "broken"}
    assert report.owner.name == "Tony"
    assert report.owner.company == "Dnaritag"
    updated = put_in(report.owner.company, "Dnarity")
    assert updated.owner.company == "Dnarity"

    updated_with_fn = update_in(report.owner.name, fn name -> "Mr. #{name}" end)
    assert updated_with_fn.owner.name == "Mr. Tony"
  end
end
