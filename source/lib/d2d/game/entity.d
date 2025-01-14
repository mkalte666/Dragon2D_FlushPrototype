/**
	d2d.game.entity holds the base class for all objects actually appearing ingame: entitys
*/
module d2d.game.entity;

import gl3n.linalg;

import d2d.core.base;


/**
	The base class for all ingame-objects (entitys)
*/
abstract class Entity : Base
{
	/** the position modes for Entities	*/
	enum PositionMode {
		absolute = 0,	/// position is absolute in world space
		relative = 1,	/// position is relative to the parent, in world space. if no parent is set, it acts like absolute
		parentBound = 3, /// position is the same as the parent; acts like absolute if no parent is set         /__ Why is this 3??
	};

	/**
		The position of this object. 
	*/
	@property vec2 pos()
	{
		return _pos;
	}
	@property vec2 pos(vec2 p)
	{
		return _pos = p;
	}

    /** 
        The position-mode of this object
    */
    @property PositionMode positionMode()
    {
        return positionMode;
    }
    @property PositionMode positionMode(PositionMode mode)
    {
        return _positionMode = mode;
    }

	/**
		The absolute position of this object
	*/
	@property vec2 absolutePos()
	{
        if (!(this.parent is null) && (cast(Entity)this.parent)) {
            auto p = (cast(Entity)this.parent);
		    switch (_positionMode) {
			    case PositionMode.relative:
                    return p.absolutePos + _pos;
			    case PositionMode.parentBound:
					return p.absolutePos;
			    default:	//just ignore this
				    break;
		    }
        }

		return _pos;
	}

private:
	/// the position-mode of this entity
	PositionMode _positionMode = PositionMode.absolute;
	/// the position of this entity
	vec2 _pos = 0;
	
}