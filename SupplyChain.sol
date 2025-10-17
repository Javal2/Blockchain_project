// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    enum State { Created, InTransit, Delivered }
    struct Item {
        string name;
        uint id;
        State state;
    }
    mapping (uint => Item) public items;
    uint[] public itemIds;
    uint public itemCount = 0;

    function createItem(string memory name) public {
        items[itemCount] = Item(name, itemCount, State.Created);
        itemIds.push(itemCount);
        itemCount++;
    }
    function moveToInTransit(uint id) public {
        require(items[id].state == State.Created, "Item not created");
        items[id].state = State.InTransit;
    }
    function deliverItem(uint id) public {
        require(items[id].state == State.InTransit, "Item not in transit");
        items[id].state = State.Delivered;
    }
    function getAllItemIds() public view returns (uint[] memory) {
        return itemIds;
    }
    function getItem(uint id) public view returns (string memory, uint, State) {
        Item memory item = items[id];
        return (item.name, item.id, item.state);
    }
}
