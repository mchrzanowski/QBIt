//
//  Terrain.m
//  Texture
//
//  Created by scholar on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapBlocks.h"
#import "Terrain.h"

TerrainTCs* terrainTCs;

@implementation Terrain

+(void) newTerrains{
	terrainTCs = malloc(BLOCK_TYPES*sizeof(TerrainTCs));
	memset(terrainTCs, 0, BLOCK_TYPES*sizeof(TerrainTCs));
	//set GRASS values
	getSubTexCoords(T_GRASS_TOP, &terrainTCs[GRASS].coords[TOP]);
	getSubTexCoords(T_GRASS_BOTTOM, &terrainTCs[GRASS].coords[BOTTOM]);
	getSubTexCoords(T_GRASS_LEFT, &terrainTCs[GRASS].coords[LEFT]);
	getSubTexCoords(T_GRASS_RIGHT, &terrainTCs[GRASS].coords[RIGHT]);
	getSubTexCoords(T_GRASS_FRONT, &terrainTCs[GRASS].coords[FRONT]);
	getSubTexCoords(T_GRASS_BACK, &terrainTCs[GRASS].coords[BACK]);
	
	//set DIRT values
	getSubTexCoords(T_DIRT_TOP, &terrainTCs[DIRT].coords[TOP]);
	getSubTexCoords(T_DIRT_BOTTOM, &terrainTCs[DIRT].coords[BOTTOM]);
	getSubTexCoords(T_DIRT_LEFT, &terrainTCs[DIRT].coords[LEFT]);
	getSubTexCoords(T_DIRT_RIGHT, &terrainTCs[DIRT].coords[RIGHT]);
	getSubTexCoords(T_DIRT_FRONT, &terrainTCs[DIRT].coords[FRONT]);
	getSubTexCoords(T_DIRT_BACK, &terrainTCs[DIRT].coords[BACK]);
	
	//set STONE values
	getSubTexCoords(T_STONE_TOP, &terrainTCs[STONE].coords[TOP]);
	getSubTexCoords(T_STONE_BOTTOM, &terrainTCs[STONE].coords[BOTTOM]);
	getSubTexCoords(T_STONE_LEFT, &terrainTCs[STONE].coords[LEFT]);
	getSubTexCoords(T_STONE_RIGHT, &terrainTCs[STONE].coords[RIGHT]);
	getSubTexCoords(T_STONE_FRONT, &terrainTCs[STONE].coords[FRONT]);
	getSubTexCoords(T_STONE_BACK, &terrainTCs[STONE].coords[BACK]);

	//set BARK values
	getSubTexCoords(T_BARK_TOP, &terrainTCs[BARK].coords[TOP]);
	getSubTexCoords(T_BARK_BOTTOM, &terrainTCs[BARK].coords[BOTTOM]);
	getSubTexCoords(T_BARK_LEFT, &terrainTCs[BARK].coords[LEFT]);
	getSubTexCoords(T_BARK_RIGHT, &terrainTCs[BARK].coords[RIGHT]);
	getSubTexCoords(T_BARK_FRONT, &terrainTCs[BARK].coords[FRONT]);
	getSubTexCoords(T_BARK_BACK, &terrainTCs[BARK].coords[BACK]);
	
	//set LEAVES values
	getSubTexCoords(T_LEAVES_TOP, &terrainTCs[LEAVES].coords[TOP]);
	getSubTexCoords(T_LEAVES_BOTTOM, &terrainTCs[LEAVES].coords[BOTTOM]);
	getSubTexCoords(T_LEAVES_LEFT, &terrainTCs[LEAVES].coords[LEFT]);
	getSubTexCoords(T_LEAVES_RIGHT, &terrainTCs[LEAVES].coords[RIGHT]);
	getSubTexCoords(T_LEAVES_FRONT, &terrainTCs[LEAVES].coords[FRONT]);
	getSubTexCoords(T_LEAVES_BACK, &terrainTCs[LEAVES].coords[BACK]);
	
	//set GRAVEL values
	getSubTexCoords(T_GRAVEL_TOP, &terrainTCs[GRAVEL].coords[TOP]);
	getSubTexCoords(T_GRAVEL_BOTTOM, &terrainTCs[GRAVEL].coords[BOTTOM]);
	getSubTexCoords(T_GRAVEL_LEFT, &terrainTCs[GRAVEL].coords[LEFT]);
	getSubTexCoords(T_GRAVEL_RIGHT, &terrainTCs[GRAVEL].coords[RIGHT]);
	getSubTexCoords(T_GRAVEL_FRONT, &terrainTCs[GRAVEL].coords[FRONT]);
	getSubTexCoords(T_GRAVEL_BACK, &terrainTCs[GRAVEL].coords[BACK]);
	
	//set COBBLESTONE values
	getSubTexCoords(T_COBBLESTONE_TOP, &terrainTCs[COBBLESTONE].coords[TOP]);
	getSubTexCoords(T_COBBLESTONE_BOTTOM, &terrainTCs[COBBLESTONE].coords[BOTTOM]);
	getSubTexCoords(T_COBBLESTONE_LEFT, &terrainTCs[COBBLESTONE].coords[LEFT]);
	getSubTexCoords(T_COBBLESTONE_RIGHT, &terrainTCs[COBBLESTONE].coords[RIGHT]);
	getSubTexCoords(T_COBBLESTONE_FRONT, &terrainTCs[COBBLESTONE].coords[FRONT]);
	getSubTexCoords(T_COBBLESTONE_BACK, &terrainTCs[COBBLESTONE].coords[BACK]);
	
	//set SAND values
	getSubTexCoords(T_SAND_TOP, &terrainTCs[SAND].coords[TOP]);
	getSubTexCoords(T_SAND_BOTTOM, &terrainTCs[SAND].coords[BOTTOM]);
	getSubTexCoords(T_SAND_LEFT, &terrainTCs[SAND].coords[LEFT]);
	getSubTexCoords(T_SAND_RIGHT, &terrainTCs[SAND].coords[RIGHT]);
	getSubTexCoords(T_SAND_FRONT, &terrainTCs[SAND].coords[FRONT]);
	getSubTexCoords(T_SAND_BACK, &terrainTCs[SAND].coords[BACK]);
	
	//set WOOD values
	getSubTexCoords(T_WOOD_TOP, &terrainTCs[WOOD].coords[TOP]);
	getSubTexCoords(T_WOOD_BOTTOM, &terrainTCs[WOOD].coords[BOTTOM]);
	getSubTexCoords(T_WOOD_LEFT, &terrainTCs[WOOD].coords[LEFT]);
	getSubTexCoords(T_WOOD_RIGHT, &terrainTCs[WOOD].coords[RIGHT]);
	getSubTexCoords(T_WOOD_FRONT, &terrainTCs[WOOD].coords[FRONT]);
	getSubTexCoords(T_WOOD_BACK, &terrainTCs[WOOD].coords[BACK]);
	
	//set BRICK values
	getSubTexCoords(T_BRICK_TOP, &terrainTCs[BRICK].coords[TOP]);
	getSubTexCoords(T_BRICK_BOTTOM, &terrainTCs[BRICK].coords[BOTTOM]);
	getSubTexCoords(T_BRICK_LEFT, &terrainTCs[BRICK].coords[LEFT]);
	getSubTexCoords(T_BRICK_RIGHT, &terrainTCs[BRICK].coords[RIGHT]);
	getSubTexCoords(T_BRICK_FRONT, &terrainTCs[BRICK].coords[FRONT]);
	getSubTexCoords(T_BRICK_BACK, &terrainTCs[BRICK].coords[BACK]);
	
	//set GOLDORE values
	getSubTexCoords(T_GOLDORE_TOP, &terrainTCs[GOLDORE].coords[TOP]);
	getSubTexCoords(T_GOLDORE_BOTTOM, &terrainTCs[GOLDORE].coords[BOTTOM]);
	getSubTexCoords(T_GOLDORE_LEFT, &terrainTCs[GOLDORE].coords[LEFT]);
	getSubTexCoords(T_GOLDORE_RIGHT, &terrainTCs[GOLDORE].coords[RIGHT]);
	getSubTexCoords(T_GOLDORE_FRONT, &terrainTCs[GOLDORE].coords[FRONT]);
	getSubTexCoords(T_GOLDORE_BACK, &terrainTCs[GOLDORE].coords[BACK]);
	
	//set PAVESTONE values
	getSubTexCoords(T_PAVESTONE_TOP, &terrainTCs[PAVESTONE].coords[TOP]);
	getSubTexCoords(T_PAVESTONE_BOTTOM, &terrainTCs[PAVESTONE].coords[BOTTOM]);
	getSubTexCoords(T_PAVESTONE_LEFT, &terrainTCs[PAVESTONE].coords[LEFT]);
	getSubTexCoords(T_PAVESTONE_RIGHT, &terrainTCs[PAVESTONE].coords[RIGHT]);
	getSubTexCoords(T_PAVESTONE_FRONT, &terrainTCs[PAVESTONE].coords[FRONT]);
	getSubTexCoords(T_PAVESTONE_BACK, &terrainTCs[PAVESTONE].coords[BACK]);
	
	//set IVY values
	getSubTexCoords(T_IVY_TOP, &terrainTCs[IVY].coords[TOP]);
	getSubTexCoords(T_IVY_BOTTOM, &terrainTCs[IVY].coords[BOTTOM]);
	getSubTexCoords(T_IVY_LEFT, &terrainTCs[IVY].coords[LEFT]);
	getSubTexCoords(T_IVY_RIGHT, &terrainTCs[IVY].coords[RIGHT]);
	getSubTexCoords(T_IVY_FRONT, &terrainTCs[IVY].coords[FRONT]);
	getSubTexCoords(T_IVY_BACK, &terrainTCs[IVY].coords[BACK]);
	
	//set REDCLOTH values
	getSubTexCoords(T_REDCLOTH_TOP, &terrainTCs[REDCLOTH].coords[TOP]);
	getSubTexCoords(T_REDCLOTH_BOTTOM, &terrainTCs[REDCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_REDCLOTH_LEFT, &terrainTCs[REDCLOTH].coords[LEFT]);
	getSubTexCoords(T_REDCLOTH_RIGHT, &terrainTCs[REDCLOTH].coords[RIGHT]);
	getSubTexCoords(T_REDCLOTH_FRONT, &terrainTCs[REDCLOTH].coords[FRONT]);
	getSubTexCoords(T_REDCLOTH_BACK, &terrainTCs[REDCLOTH].coords[BACK]);
	
	//set STEEL values
	getSubTexCoords(T_STEEL_TOP, &terrainTCs[STEEL].coords[TOP]);
	getSubTexCoords(T_STEEL_BOTTOM, &terrainTCs[STEEL].coords[BOTTOM]);
	getSubTexCoords(T_STEEL_LEFT, &terrainTCs[STEEL].coords[LEFT]);
	getSubTexCoords(T_STEEL_RIGHT, &terrainTCs[STEEL].coords[RIGHT]);
	getSubTexCoords(T_STEEL_FRONT, &terrainTCs[STEEL].coords[FRONT]);
	getSubTexCoords(T_STEEL_BACK, &terrainTCs[STEEL].coords[BACK]);
	
	//set GOLD values
	getSubTexCoords(T_GOLD_TOP, &terrainTCs[GOLD].coords[TOP]);
	getSubTexCoords(T_GOLD_BOTTOM, &terrainTCs[GOLD].coords[BOTTOM]);
	getSubTexCoords(T_GOLD_LEFT, &terrainTCs[GOLD].coords[LEFT]);
	getSubTexCoords(T_GOLD_RIGHT, &terrainTCs[GOLD].coords[RIGHT]);
	getSubTexCoords(T_GOLD_FRONT, &terrainTCs[GOLD].coords[FRONT]);
	getSubTexCoords(T_GOLD_BACK, &terrainTCs[GOLD].coords[BACK]);
	
	//set DIAMOND values
	getSubTexCoords(T_DIAMOND_TOP, &terrainTCs[DIAMOND].coords[TOP]);
	getSubTexCoords(T_DIAMOND_BOTTOM, &terrainTCs[DIAMOND].coords[BOTTOM]);
	getSubTexCoords(T_DIAMOND_LEFT, &terrainTCs[DIAMOND].coords[LEFT]);
	getSubTexCoords(T_DIAMOND_RIGHT, &terrainTCs[DIAMOND].coords[RIGHT]);
	getSubTexCoords(T_DIAMOND_FRONT, &terrainTCs[DIAMOND].coords[FRONT]);
	getSubTexCoords(T_DIAMOND_BACK, &terrainTCs[DIAMOND].coords[BACK]);
	
	//set ORANGECLOTH values
	getSubTexCoords(T_ORANGECLOTH_TOP, &terrainTCs[ORANGECLOTH].coords[TOP]);
	getSubTexCoords(T_ORANGECLOTH_BOTTOM, &terrainTCs[ORANGECLOTH].coords[BOTTOM]);
	getSubTexCoords(T_ORANGECLOTH_LEFT, &terrainTCs[ORANGECLOTH].coords[LEFT]);
	getSubTexCoords(T_ORANGECLOTH_RIGHT, &terrainTCs[ORANGECLOTH].coords[RIGHT]);
	getSubTexCoords(T_ORANGECLOTH_FRONT, &terrainTCs[ORANGECLOTH].coords[FRONT]);
	getSubTexCoords(T_ORANGECLOTH_BACK, &terrainTCs[ORANGECLOTH].coords[BACK]);
	
	//set YELLOWCLOTH values
	getSubTexCoords(T_YELLOWCLOTH_TOP, &terrainTCs[YELLOWCLOTH].coords[TOP]);
	getSubTexCoords(T_YELLOWCLOTH_BOTTOM, &terrainTCs[YELLOWCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_YELLOWCLOTH_LEFT, &terrainTCs[YELLOWCLOTH].coords[LEFT]);
	getSubTexCoords(T_YELLOWCLOTH_RIGHT, &terrainTCs[YELLOWCLOTH].coords[RIGHT]);
	getSubTexCoords(T_YELLOWCLOTH_FRONT, &terrainTCs[YELLOWCLOTH].coords[FRONT]);
	getSubTexCoords(T_YELLOWCLOTH_BACK, &terrainTCs[YELLOWCLOTH].coords[BACK]);
	
	//set GREENCLOTH values
	getSubTexCoords(T_GREENCLOTH_TOP, &terrainTCs[GREENCLOTH].coords[TOP]);
	getSubTexCoords(T_GREENCLOTH_BOTTOM, &terrainTCs[GREENCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_GREENCLOTH_LEFT, &terrainTCs[GREENCLOTH].coords[LEFT]);
	getSubTexCoords(T_GREENCLOTH_RIGHT, &terrainTCs[GREENCLOTH].coords[RIGHT]);
	getSubTexCoords(T_GREENCLOTH_FRONT, &terrainTCs[GREENCLOTH].coords[FRONT]);
	getSubTexCoords(T_GREENCLOTH_BACK, &terrainTCs[GREENCLOTH].coords[BACK]);
	
	//set TEALCLOTH values
	getSubTexCoords(T_TEALCLOTH_TOP, &terrainTCs[TEALCLOTH].coords[TOP]);
	getSubTexCoords(T_TEALCLOTH_BOTTOM, &terrainTCs[TEALCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_TEALCLOTH_LEFT, &terrainTCs[TEALCLOTH].coords[LEFT]);
	getSubTexCoords(T_TEALCLOTH_RIGHT, &terrainTCs[TEALCLOTH].coords[RIGHT]);
	getSubTexCoords(T_TEALCLOTH_FRONT, &terrainTCs[TEALCLOTH].coords[FRONT]);
	getSubTexCoords(T_TEALCLOTH_BACK, &terrainTCs[TEALCLOTH].coords[BACK]);
	
	//set LIMECLOTH values
	getSubTexCoords(T_LIMECLOTH_TOP, &terrainTCs[LIMECLOTH].coords[TOP]);
	getSubTexCoords(T_LIMECLOTH_BOTTOM, &terrainTCs[LIMECLOTH].coords[BOTTOM]);
	getSubTexCoords(T_LIMECLOTH_LEFT, &terrainTCs[LIMECLOTH].coords[LEFT]);
	getSubTexCoords(T_LIMECLOTH_RIGHT, &terrainTCs[LIMECLOTH].coords[RIGHT]);
	getSubTexCoords(T_LIMECLOTH_FRONT, &terrainTCs[LIMECLOTH].coords[FRONT]);
	getSubTexCoords(T_LIMECLOTH_BACK, &terrainTCs[LIMECLOTH].coords[BACK]);
	
	//set AQUACLOTH values
	getSubTexCoords(T_AQUACLOTH_TOP, &terrainTCs[AQUACLOTH].coords[TOP]);
	getSubTexCoords(T_AQUACLOTH_BOTTOM, &terrainTCs[AQUACLOTH].coords[BOTTOM]);
	getSubTexCoords(T_AQUACLOTH_LEFT, &terrainTCs[AQUACLOTH].coords[LEFT]);
	getSubTexCoords(T_AQUACLOTH_RIGHT, &terrainTCs[AQUACLOTH].coords[RIGHT]);
	getSubTexCoords(T_AQUACLOTH_FRONT, &terrainTCs[AQUACLOTH].coords[FRONT]);
	getSubTexCoords(T_AQUACLOTH_BACK, &terrainTCs[AQUACLOTH].coords[BACK]);
	
	//set SKYCLOTH values
	getSubTexCoords(T_SKYCLOTH_TOP, &terrainTCs[SKYCLOTH].coords[TOP]);
	getSubTexCoords(T_SKYCLOTH_BOTTOM, &terrainTCs[SKYCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_SKYCLOTH_LEFT, &terrainTCs[SKYCLOTH].coords[LEFT]);
	getSubTexCoords(T_SKYCLOTH_RIGHT, &terrainTCs[SKYCLOTH].coords[RIGHT]);
	getSubTexCoords(T_SKYCLOTH_FRONT, &terrainTCs[SKYCLOTH].coords[FRONT]);
	getSubTexCoords(T_SKYCLOTH_BACK, &terrainTCs[SKYCLOTH].coords[BACK]);
	
	//set DARKBLUECLOTH values
	getSubTexCoords(T_DARKBLUECLOTH_TOP, &terrainTCs[DARKBLUECLOTH].coords[TOP]);
	getSubTexCoords(T_DARKBLUECLOTH_BOTTOM, &terrainTCs[DARKBLUECLOTH].coords[BOTTOM]);
	getSubTexCoords(T_DARKBLUECLOTH_LEFT, &terrainTCs[DARKBLUECLOTH].coords[LEFT]);
	getSubTexCoords(T_DARKBLUECLOTH_RIGHT, &terrainTCs[DARKBLUECLOTH].coords[RIGHT]);
	getSubTexCoords(T_DARKBLUECLOTH_FRONT, &terrainTCs[DARKBLUECLOTH].coords[FRONT]);
	getSubTexCoords(T_DARKBLUECLOTH_BACK, &terrainTCs[DARKBLUECLOTH].coords[BACK]);
	
	//set PURPLECLOTH values
	getSubTexCoords(T_PURPLECLOTH_TOP, &terrainTCs[PURPLECLOTH].coords[TOP]);
	getSubTexCoords(T_PURPLECLOTH_BOTTOM, &terrainTCs[PURPLECLOTH].coords[BOTTOM]);
	getSubTexCoords(T_PURPLECLOTH_LEFT, &terrainTCs[PURPLECLOTH].coords[LEFT]);
	getSubTexCoords(T_PURPLECLOTH_RIGHT, &terrainTCs[PURPLECLOTH].coords[RIGHT]);
	getSubTexCoords(T_PURPLECLOTH_FRONT, &terrainTCs[PURPLECLOTH].coords[FRONT]);
	getSubTexCoords(T_PURPLECLOTH_BACK, &terrainTCs[PURPLECLOTH].coords[BACK]);
	
	//set VIOLETCLOTH values
	getSubTexCoords(T_VIOLETCLOTH_TOP, &terrainTCs[VIOLETCLOTH].coords[TOP]);
	getSubTexCoords(T_VIOLETCLOTH_BOTTOM, &terrainTCs[VIOLETCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_VIOLETCLOTH_LEFT, &terrainTCs[VIOLETCLOTH].coords[LEFT]);
	getSubTexCoords(T_VIOLETCLOTH_RIGHT, &terrainTCs[VIOLETCLOTH].coords[RIGHT]);
	getSubTexCoords(T_VIOLETCLOTH_FRONT, &terrainTCs[VIOLETCLOTH].coords[FRONT]);
	getSubTexCoords(T_VIOLETCLOTH_BACK, &terrainTCs[VIOLETCLOTH].coords[BACK]);
	
	//set MAGENTACLOTH values
	getSubTexCoords(T_MAGENTACLOTH_TOP, &terrainTCs[MAGENTACLOTH].coords[TOP]);
	getSubTexCoords(T_MAGENTACLOTH_BOTTOM, &terrainTCs[MAGENTACLOTH].coords[BOTTOM]);
	getSubTexCoords(T_MAGENTACLOTH_LEFT, &terrainTCs[MAGENTACLOTH].coords[LEFT]);
	getSubTexCoords(T_MAGENTACLOTH_RIGHT, &terrainTCs[MAGENTACLOTH].coords[RIGHT]);
	getSubTexCoords(T_MAGENTACLOTH_FRONT, &terrainTCs[MAGENTACLOTH].coords[FRONT]);
	getSubTexCoords(T_MAGENTACLOTH_BACK, &terrainTCs[MAGENTACLOTH].coords[BACK]);
	
	//set BLACKCLOTH values
	getSubTexCoords(T_BLACKCLOTH_TOP, &terrainTCs[BLACKCLOTH].coords[TOP]);
	getSubTexCoords(T_BLACKCLOTH_BOTTOM, &terrainTCs[BLACKCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_BLACKCLOTH_LEFT, &terrainTCs[BLACKCLOTH].coords[LEFT]);
	getSubTexCoords(T_BLACKCLOTH_RIGHT, &terrainTCs[BLACKCLOTH].coords[RIGHT]);
	getSubTexCoords(T_BLACKCLOTH_FRONT, &terrainTCs[BLACKCLOTH].coords[FRONT]);
	getSubTexCoords(T_BLACKCLOTH_BACK, &terrainTCs[BLACKCLOTH].coords[BACK]);

	//set GREYCLOTH values
	getSubTexCoords(T_GREYCLOTH_TOP, &terrainTCs[GREYCLOTH].coords[TOP]);
	getSubTexCoords(T_GREYCLOTH_BOTTOM, &terrainTCs[GREYCLOTH].coords[BOTTOM]);
	getSubTexCoords(T_GREYCLOTH_LEFT, &terrainTCs[GREYCLOTH].coords[LEFT]);
	getSubTexCoords(T_GREYCLOTH_RIGHT, &terrainTCs[GREYCLOTH].coords[RIGHT]);
	getSubTexCoords(T_GREYCLOTH_FRONT, &terrainTCs[GREYCLOTH].coords[FRONT]);
	getSubTexCoords(T_GREYCLOTH_BACK, &terrainTCs[GREYCLOTH].coords[BACK]);
	
	//set WHITECLOTH values
	getSubTexCoords(T_WHITECLOTH_TOP, &terrainTCs[WHITECLOTH].coords[TOP]);
	getSubTexCoords(T_WHITECLOTH_BOTTOM, &terrainTCs[WHITECLOTH].coords[BOTTOM]);
	getSubTexCoords(T_WHITECLOTH_LEFT, &terrainTCs[WHITECLOTH].coords[LEFT]);
	getSubTexCoords(T_WHITECLOTH_RIGHT, &terrainTCs[WHITECLOTH].coords[RIGHT]);
	getSubTexCoords(T_WHITECLOTH_FRONT, &terrainTCs[WHITECLOTH].coords[FRONT]);
	getSubTexCoords(T_WHITECLOTH_BACK, &terrainTCs[WHITECLOTH].coords[BACK]);
	
}

@end

