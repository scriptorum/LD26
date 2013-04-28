package ld26.component;

import ash.core.Entity;

// Refers to some parent entity
class Parent
{
	public var entity:Entity;

	public function new(entity:Entity)
	{
		this.entity = entity;
	}
}

// Refers to some child entity
class Child
{
	public var entity:Entity;

	public function new(entity:Entity)
	{
		this.entity = entity;
	}
}

