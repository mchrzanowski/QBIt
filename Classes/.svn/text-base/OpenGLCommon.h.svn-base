#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_EMBEDDED
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#else
#import <OpenGL/OpenGL.h>
#endif
@class OpenGLWaveFrontMaterial;

#pragma mark -
#pragma mark Color3D
#pragma mark -
typedef struct {
	GLfloat	red;
	GLfloat	green;
	GLfloat	blue;
	GLfloat alpha;
} Color3D;
static inline Color3D Color3DMake(CGFloat inRed, CGFloat inGreen, CGFloat inBlue, CGFloat inAlpha)
{
    Color3D ret;
	ret.red = inRed;
	ret.green = inGreen;
	ret.blue = inBlue;
	ret.alpha = inAlpha;
    return ret;
}
static inline void Color3DSet(Color3D *color, CGFloat inRed, CGFloat inGreen, CGFloat inBlue, CGFloat inAlpha)
{
    color->red = inRed;
    color->green = inGreen;
    color->blue = inBlue;
    color->alpha = inAlpha;
}
#pragma mark -
#pragma mark Vertex3D
#pragma mark -
typedef struct {
	GLfloat	x;
	GLfloat y;
	GLfloat z;
} Vertex3D;

static inline Vertex3D Vertex3DMake(CGFloat inX, CGFloat inY, CGFloat inZ)
{
	Vertex3D ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}
static inline void Vertex3DSet(Vertex3D *vertex, CGFloat inX, CGFloat inY, CGFloat inZ)
{
    vertex->x = inX;
    vertex->y = inY;
    vertex->z = inZ;
}
#pragma mark -
#pragma mark Vector3D
#pragma mark -
typedef Vertex3D Vector3D;
#define Vector3DMake(x,y,z) (Vector3D)Vertex3DMake(x, y, z)
#define Vector3DSet(vector,x,y,z) Vertex3DSet(vector, x, y, z)
typedef struct {
	Vector3D normal;
	Vector3D point;
	float distance;
} Plane;
static inline GLfloat Vector3DMagnitude(Vector3D vector)
{
	return sqrtf((vector.x * vector.x) + (vector.y * vector.y) + (vector.z * vector.z)); 
}

static inline Vector3D Vector3DSubtract(Vector3D *vector1, Vector3D *vector2) {
		
		Vector3D res;
		
		res.x = vector1->x - vector2->x;
		res.y = vector1->y - vector2->y;
		res.z = vector1->z - vector2->z;
		
	return res;
}


static inline float Vector3DInnerProduct(Vector3D v1, Vector3D v2) {
	
	return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z);
}

typedef struct {
	GLfloat x;
	GLfloat y;
} Vector2D;

static inline void Vector2DNormalize(Vector2D *vector){
	GLfloat vecMag = sqrtf( (vector->x * vector->x) + (vector->y * vector->y) );
	if( vecMag == 0.f){
		vector->x = 1.0;
		vector->y = 0.0;
		return;
	}
	vector->x /= vecMag;
	vector->y /= vecMag;
}
	
static inline void Vector3DNormalize(Vector3D *vector){
	GLfloat vecMag = Vector3DMagnitude(*vector);
	if ( vecMag == 0.0 ){
		vector->x = 1.0;
		vector->y = 0.0;
		vector->z = 0.0;
        return;
	}
	vector->x /= vecMag;
	vector->y /= vecMag;
	vector->z /= vecMag;
}
static inline GLfloat Vector3DDotProduct(Vector3D vector1, Vector3D vector2)
{		
	return vector1.x*vector2.x + vector1.y*vector2.y + vector1.z*vector2.z;
	
}


static inline Vector3D Vector3DCrossProduct(Vector3D *vector1, Vector3D *vector2)
{
	Vector3D ret;
	ret.x = (vector1->y * vector2->z) - (vector1->z * vector2->y);
	ret.y = (vector1->z * vector2->x) - (vector1->x * vector2->z);
	ret.z = (vector1->x * vector2->y) - (vector1->y * vector2->x);
	return ret;
}
static inline Vector3D Vector3DMakeWithStartAndEndPoints(Vertex3D start, Vertex3D end)
{
	Vector3D ret;
	ret.x = end.x - start.x;
	ret.y = end.y - start.y;
	ret.z = end.z - start.z;
	Vector3DNormalize(&ret);
	return ret;
}
static inline Vector3D Vector3DAdd(Vector3D *vector1, Vector3D *vector2)
{
	Vector3D ret;
	ret.x = vector1->x + vector2->x;
	ret.y = vector1->y + vector2->y;
	ret.z = vector1->z + vector2->z;
	return ret;
}

static inline Vector3D Vector3DMultiplyScalar(Vector3D *vector1, float scalar){
	Vector3D res;
	
	res.x = vector1->x * scalar;
	res.y = vector1->y * scalar;
	res.z = vector1->z * scalar;
	
	return res;
}
static inline void Vector3DFlip (Vector3D *vector)
{
	vector->x = -vector->x;
	vector->y = -vector->y;
	vector->z = -vector->z;
}
#pragma mark -
#pragma mark Rotation3D
#pragma mark -
// A Rotation3D is just a Vertex3D used to store three angles (pitch, yaw, roll) instead of cartesian coordinates. 
// For simplicity, we just reuse the Vertex3D, even though the member names should probably be either xRot, yRot, 
// and zRot, or else pitch, yaw, roll. 
typedef Vertex3D Rotation3D;
#define Rotation3DMake(x,y,z) (Rotation3D)Vertex3DMake(x, y, z)
#pragma mark -
#pragma mark Face3D
#pragma mark -
// Face3D is used to hold three integers which will be integer index values to another array
typedef struct {
	GLushort	v1;
	GLushort	v2;
	GLushort	v3;
} Face3D;
static inline Face3D Face3DMake(int v1, int v2, int v3)
{
	Face3D ret;
	ret.v1 = v1;
	ret.v2 = v2;
	ret.v3 = v3;
	return ret;
}
#pragma mark -
#pragma mark Triangle3D
#pragma mark -
typedef struct {
	Vertex3D v1;
	Vertex3D v2;
	Vertex3D v3;
} Triangle3D;
static inline Triangle3D Triangle3DMake(Vertex3D inV1, Vertex3D inV2, Vertex3D inV3)
{
	Triangle3D ret;
	ret.v1 = inV1;
	ret.v2 = inV2;
	ret.v3 = inV3;
	return ret;
}
static inline Vector3D Triangle3DCalculateSurfaceNormal(Triangle3D triangle)
{
	Vector3D u = Vector3DMakeWithStartAndEndPoints(triangle.v2, triangle.v1);
	Vector3D v = Vector3DMakeWithStartAndEndPoints(triangle.v3, triangle.v1);
	
	Vector3D ret;
	ret.x = (u.y * v.z) - (u.z * v.y);
	ret.y = (u.z * v.x) - (u.x * v.z);
	ret.z = (u.x * v.y) - (u.y * v.x);
	return ret;
}
#pragma mark -
#pragma mark VertexTextureCombinations
#pragma mark -
// This implements a binary search tree that will help us determine which vertices need to be duplicated. In
// OpenGL, each vertex has to have one and only one set of texture coordinates, so if a single vertex is shared
// by multiple triangles and has different texture coordinates in each, those vertices need to be duplicated
// so that there is one copy of that vertex for every distinct set of texture coordinates.

// This works with index values, not actual Vertex3D values, for speed, and because that's the way the 
// OBJ file format tells us about them
//
// An actualVertex value of UINT_MAX means that the actual integer value hasn't been determined yet. 
typedef struct {
	GLuint	originalVertex;
	GLuint	textureCoords;
	GLuint	actualVertex;
	void	*greater;
	void	*lesser;
	
} VertexTextureIndex;
static inline VertexTextureIndex * VertexTextureIndexMake (GLuint inVertex, GLuint inTextureCoords, GLuint inActualVertex)
{
	VertexTextureIndex *ret = malloc(sizeof(VertexTextureIndex));
	ret->originalVertex = inVertex;
	ret->textureCoords = inTextureCoords;
	ret->actualVertex = inActualVertex;
	ret->greater = NULL;
	ret->lesser = NULL;
	return ret;
}
#define VertexTextureIndexMakeEmpty(x,y) VertexTextureIndexMake(x, y, UINT_MAX)
// recursive search function - looks for a match for a given combination of vertex and 
// texture coordinates. If not found, returns UINT_MAX
static inline GLuint VertexTextureIndexMatch(VertexTextureIndex *node, GLuint matchVertex, GLuint matchTextureCoords)
{
	if (node->originalVertex == matchVertex && node->textureCoords == matchTextureCoords)
		return node->actualVertex;
	
	if (node->greater != NULL)
	{
		GLuint greaterIndex = VertexTextureIndexMatch(node->greater, matchVertex, matchTextureCoords);
		if (greaterIndex != UINT_MAX)
			return greaterIndex;
	}
	
	if (node->lesser != NULL)
	{
		GLuint lesserIndex = VertexTextureIndexMatch(node->lesser, matchVertex, matchTextureCoords);
		return lesserIndex;
	}
	return UINT_MAX;
}
static inline VertexTextureIndex * VertexTextureIndexAddNode(VertexTextureIndex *node, GLuint newVertex, GLuint newTextureCoords)
{
	// If requested new node matches the one being added to, then don't add, just return pointer to match
	if (node->originalVertex == newVertex && node->textureCoords == newTextureCoords)
		return node;
	if (node->originalVertex > newVertex || (node->originalVertex == newVertex && node->textureCoords > newTextureCoords))
	{
		if (node->lesser != NULL)
			return VertexTextureIndexAddNode(node->lesser, newVertex, newTextureCoords);
		else
		{
			VertexTextureIndex *newNode = VertexTextureIndexMakeEmpty(newVertex, newTextureCoords);
			node->lesser = newNode;
			return node->lesser;
		}
	}
	else
	{
		if (node->greater != NULL)
			return VertexTextureIndexAddNode(node->greater, newVertex, newTextureCoords);
		else
		{
			VertexTextureIndex *newNode = VertexTextureIndexMakeEmpty(newVertex, newTextureCoords);
			node->greater = newNode;
			return node->greater;
		}	
	}
	return NULL; // shouldn't ever reach here.
}
static inline BOOL VertexTextureIndexContainsVertexIndex(VertexTextureIndex *node, GLuint matchVertex)
{
	if (node->originalVertex == matchVertex)
		return YES;
	
	BOOL greaterHas = NO;
	BOOL lesserHas = NO;
	
	if (node->greater != NULL)
		greaterHas = VertexTextureIndexContainsVertexIndex(node->greater, matchVertex);
	if (node->lesser != NULL)
		lesserHas = VertexTextureIndexContainsVertexIndex(node->lesser, matchVertex);
	return lesserHas || greaterHas;
}
static inline void VertexTextureIndexFree(VertexTextureIndex *node)
{
	if (node != NULL)
	{
		if (node->greater != NULL)
			VertexTextureIndexFree(node->greater);
		if (node->lesser != NULL)
			VertexTextureIndexFree(node->lesser);
		free(node);
	}
	
}
static inline GLuint VertexTextureIndexCountNodes(VertexTextureIndex *node)
{
	GLuint ret = 0;  
	
	if (node)
	{
		ret++; // count this node
		
		// Add the children
		if (node->greater != NULL)
			ret += VertexTextureIndexCountNodes(node->greater);
		if (node->lesser != NULL)
			ret += VertexTextureIndexCountNodes(node->lesser);
	}
	return ret;
}
#pragma mark -
#pragma mark Missing GLUT Functionality
// This is a modified version of the function of the same name from 
// the Mesa3D project ( http://mesa3d.org/ ), which is  licensed
// under the MIT license, which allows use, modification, and 
// redistribution
static inline void gluLookAt(GLfloat eyex, GLfloat eyey, GLfloat eyez,
							 GLfloat centerx, GLfloat centery, GLfloat centerz,
							 GLfloat upx, GLfloat upy, GLfloat upz)
{
	GLfloat m[16];
	GLfloat x[3], y[3], z[3];
	GLfloat mag;
	
	/* Make rotation matrix */
	
	/* Z vector */
	z[0] = eyex - centerx;
	z[1] = eyey - centery;
	z[2] = eyez - centerz;
	mag = sqrtf(z[0] * z[0] + z[1] * z[1] + z[2] * z[2]);
	if (mag) {			/* mpichler, 19950515 */
		z[0] /= mag;
		z[1] /= mag;
		z[2] /= mag;
	}
	
	/* Y vector */
	y[0] = upx;
	y[1] = upy;
	y[2] = upz;
	
	/* X vector = Y cross Z */
	x[0] = y[1] * z[2] - y[2] * z[1];
	x[1] = -y[0] * z[2] + y[2] * z[0];
	x[2] = y[0] * z[1] - y[1] * z[0];
	
	/* Recompute Y = Z cross X */
	y[0] = z[1] * x[2] - z[2] * x[1];
	y[1] = -z[0] * x[2] + z[2] * x[0];
	y[2] = z[0] * x[1] - z[1] * x[0];
	
	/* mpichler, 19950515 */
	/* cross product gives area of parallelogram, which is < 1.0 for
	 * non-perpendicular unit-length vectors; so normalize x, y here
	 */
	
	mag = sqrtf(x[0] * x[0] + x[1] * x[1] + x[2] * x[2]);
	if (mag) {
		x[0] /= mag;
		x[1] /= mag;
		x[2] /= mag;
	}
	
	mag = sqrtf(y[0] * y[0] + y[1] * y[1] + y[2] * y[2]);
	if (mag) {
		y[0] /= mag;
		y[1] /= mag;
		y[2] /= mag;
	}
	
#define M(row,col)  m[col*4+row]
	M(0, 0) = x[0];
	M(0, 1) = x[1];
	M(0, 2) = x[2];
	M(0, 3) = 0.0;
	M(1, 0) = y[0];
	M(1, 1) = y[1];
	M(1, 2) = y[2];
	M(1, 3) = 0.0;
	M(2, 0) = z[0];
	M(2, 1) = z[1];
	M(2, 2) = z[2];
	M(2, 3) = 0.0;
	M(3, 0) = 0.0;
	M(3, 1) = 0.0;
	M(3, 2) = 0.0;
	M(3, 3) = 1.0;
#undef M
	glMultMatrixf(m);
	
	/* Translate Eye to Origin */
	glTranslatef(-eyex, -eyey, -eyez);
	
}

static inline Plane createPlane(Vector3D v1, Vector3D v2, Vector3D v3){
	Plane newPlane;
	
	Vector3D aux1 = Vector3DSubtract(&v1, &v2);
	Vector3D aux2 = Vector3DSubtract(&v3, &v2);
	
	newPlane.normal = Vector3DCrossProduct(&aux2,&aux1);
	Vector3DNormalize(&newPlane.normal);
	newPlane.point = v2;
	newPlane.distance = -(Vector3DInnerProduct(newPlane.normal, newPlane.point));
	
	return newPlane;
}

static inline float planarDistance(Plane p, Vector3D v) {
	return (p.distance + Vector3DInnerProduct(p.normal, v) );
}

#define	PI 3.141592653589793

static inline void gluPerspective(GLfloat fovy, GLfloat aspect, GLfloat zNear, GLfloat zFar)
{
	GLfloat xmin, xmax, ymin, ymax;
	
	ymax = zNear * tanf(fovy * PI / 360.0f);
	ymin = -ymax;
	
	xmin = ymin * aspect;
	xmax = ymax * aspect;
	
	glFrustumf(xmin, xmax, ymin, ymax, zNear, zFar);
}

#undef PI

static void MultiplyMatrices4by4OpenGL_FLOAT(float *result, float *matrix1, float *matrix2);
static void MultiplyMatrixByVector4by4OpenGL_FLOAT(float *resultvector, const float *matrix, const float *pvector);
static int glhInvertMatrixf2(float *m, float *outm);

static inline int gluUnProjectf(float winx, float winy, float winz, float* modelview, float* projection, float* viewport, float *objectCoordinate){
	//Transformation matrices
	float m[16], A[16];
	float inv[4], outv[4];
	//Calculation for inverting a matrix, compute projection x modelview
	//and store in A[16]
	MultiplyMatrices4by4OpenGL_FLOAT(A, projection, modelview);
	//Now compute the inverse of matrix A
	if(glhInvertMatrixf2(A, m)==0)
		return 0;
	//Transformation of normalized coordinates between -1 and 1
	inv[0]=(winx-(float)viewport[0])/(float)viewport[2]*2.0-1.0;
	inv[1]=(winy-(float)viewport[1])/(float)viewport[3]*2.0-1.0;
	inv[2]=2.0*winz-1.0;
	inv[3]=1.0;
	//Objects coordinates
	MultiplyMatrixByVector4by4OpenGL_FLOAT(outv, m, inv);
	if(outv[3]==0.0)
		return 0;
	outv[3]=1.0/outv[3];
	objectCoordinate[0]=outv[0]*outv[3];
	objectCoordinate[1]=outv[1]*outv[3];
	objectCoordinate[2]=outv[2]*outv[3];
	return 1;
}

static inline void MultiplyMatrices4by4OpenGL_FLOAT(float *result, float *matrix1, float *matrix2){
    result[0]=matrix1[0]*matrix2[0]+
	matrix1[4]*matrix2[1]+
	matrix1[8]*matrix2[2]+
	matrix1[12]*matrix2[3];
    result[4]=matrix1[0]*matrix2[4]+
	matrix1[4]*matrix2[5]+
	matrix1[8]*matrix2[6]+
	matrix1[12]*matrix2[7];
    result[8]=matrix1[0]*matrix2[8]+
	matrix1[4]*matrix2[9]+
	matrix1[8]*matrix2[10]+
	matrix1[12]*matrix2[11];
    result[12]=matrix1[0]*matrix2[12]+
	matrix1[4]*matrix2[13]+
	matrix1[8]*matrix2[14]+
	matrix1[12]*matrix2[15];
    result[1]=matrix1[1]*matrix2[0]+
	matrix1[5]*matrix2[1]+
	matrix1[9]*matrix2[2]+
	matrix1[13]*matrix2[3];
    result[5]=matrix1[1]*matrix2[4]+
	matrix1[5]*matrix2[5]+
	matrix1[9]*matrix2[6]+
	matrix1[13]*matrix2[7];
    result[9]=matrix1[1]*matrix2[8]+
	matrix1[5]*matrix2[9]+
	matrix1[9]*matrix2[10]+
	matrix1[13]*matrix2[11];
    result[13]=matrix1[1]*matrix2[12]+
	matrix1[5]*matrix2[13]+
	matrix1[9]*matrix2[14]+
	matrix1[13]*matrix2[15];
    result[2]=matrix1[2]*matrix2[0]+
	matrix1[6]*matrix2[1]+
	matrix1[10]*matrix2[2]+
	matrix1[14]*matrix2[3];
    result[6]=matrix1[2]*matrix2[4]+
	matrix1[6]*matrix2[5]+
	matrix1[10]*matrix2[6]+
	matrix1[14]*matrix2[7];
    result[10]=matrix1[2]*matrix2[8]+
	matrix1[6]*matrix2[9]+
	matrix1[10]*matrix2[10]+
	matrix1[14]*matrix2[11];
    result[14]=matrix1[2]*matrix2[12]+
	matrix1[6]*matrix2[13]+
	matrix1[10]*matrix2[14]+
	matrix1[14]*matrix2[15];
    result[3]=matrix1[3]*matrix2[0]+
	matrix1[7]*matrix2[1]+
	matrix1[11]*matrix2[2]+
	matrix1[15]*matrix2[3];
    result[7]=matrix1[3]*matrix2[4]+
	matrix1[7]*matrix2[5]+
	matrix1[11]*matrix2[6]+
	matrix1[15]*matrix2[7];
    result[11]=matrix1[3]*matrix2[8]+
	matrix1[7]*matrix2[9]+
	matrix1[11]*matrix2[10]+
	matrix1[15]*matrix2[11];
    result[15]=matrix1[3]*matrix2[12]+
	matrix1[7]*matrix2[13]+
	matrix1[11]*matrix2[14]+
	matrix1[15]*matrix2[15];
}

static inline void MultiplyMatrixByVector4by4OpenGL_FLOAT(float *resultvector, const float *matrix, const float *pvector)
{
    resultvector[0]=matrix[0]*pvector[0]+matrix[4]*pvector[1]+matrix[8]*pvector[2]+matrix[12]*pvector[3];
    resultvector[1]=matrix[1]*pvector[0]+matrix[5]*pvector[1]+matrix[9]*pvector[2]+matrix[13]*pvector[3];
    resultvector[2]=matrix[2]*pvector[0]+matrix[6]*pvector[1]+matrix[10]*pvector[2]+matrix[14]*pvector[3];
    resultvector[3]=matrix[3]*pvector[0]+matrix[7]*pvector[1]+matrix[11]*pvector[2]+matrix[15]*pvector[3];
}

#define SWAP_ROWS_DOUBLE(a, b) { double *_tmp = a; (a)=(b); (b)=_tmp; }
#define SWAP_ROWS_FLOAT(a, b) { float *_tmp = a; (a)=(b); (b)=_tmp; }
#define MAT(m,r,c) (m)[(c)*4+(r)]

//This code comes directly from GLU except that it is for float
static inline int glhInvertMatrixf2(float *m, float *outm){
	float wtmp[4][8];
	float m0, m1, m2, m3, s;
	float *r0, *r1, *r2, *r3;
	r0 = wtmp[0], r1 = wtmp[1], r2 = wtmp[2], r3 = wtmp[3];
	r0[0] = MAT(m, 0, 0), r0[1] = MAT(m, 0, 1),
	r0[2] = MAT(m, 0, 2), r0[3] = MAT(m, 0, 3),
	r0[4] = 1.0, r0[5] = r0[6] = r0[7] = 0.0,
	r1[0] = MAT(m, 1, 0), r1[1] = MAT(m, 1, 1),
	r1[2] = MAT(m, 1, 2), r1[3] = MAT(m, 1, 3),
	r1[5] = 1.0, r1[4] = r1[6] = r1[7] = 0.0,
	r2[0] = MAT(m, 2, 0), r2[1] = MAT(m, 2, 1),
	r2[2] = MAT(m, 2, 2), r2[3] = MAT(m, 2, 3),
	r2[6] = 1.0, r2[4] = r2[5] = r2[7] = 0.0,
	r3[0] = MAT(m, 3, 0), r3[1] = MAT(m, 3, 1),
	r3[2] = MAT(m, 3, 2), r3[3] = MAT(m, 3, 3),
	r3[7] = 1.0, r3[4] = r3[5] = r3[6] = 0.0;
	/* choose pivot - or die */
	if (fabsf(r3[0]) > fabsf(r2[0]))
		SWAP_ROWS_FLOAT(r3, r2);
	if (fabsf(r2[0]) > fabsf(r1[0]))
		SWAP_ROWS_FLOAT(r2, r1);
	if (fabsf(r1[0]) > fabsf(r0[0]))
		SWAP_ROWS_FLOAT(r1, r0);
	if (0.0 == r0[0])
		return 0;
	/* eliminate first variable     */
	m1 = r1[0] / r0[0];
	m2 = r2[0] / r0[0];
	m3 = r3[0] / r0[0];
	s = r0[1];
	r1[1] -= m1 * s;
	r2[1] -= m2 * s;
	r3[1] -= m3 * s;
	s = r0[2];
	r1[2] -= m1 * s;
	r2[2] -= m2 * s;
	r3[2] -= m3 * s;
	s = r0[3];
	r1[3] -= m1 * s;
	r2[3] -= m2 * s;
	r3[3] -= m3 * s;
	s = r0[4];
	if (s != 0.0) {
		r1[4] -= m1 * s;
		r2[4] -= m2 * s;
		r3[4] -= m3 * s;
	}
	s = r0[5];
	if (s != 0.0) {
		r1[5] -= m1 * s;
		r2[5] -= m2 * s;
		r3[5] -= m3 * s;
	}
	s = r0[6];
	if (s != 0.0) {
		r1[6] -= m1 * s;
		r2[6] -= m2 * s;
		r3[6] -= m3 * s;
	}
	s = r0[7];
	if (s != 0.0) {
		r1[7] -= m1 * s;
		r2[7] -= m2 * s;
		r3[7] -= m3 * s;
	}
	/* choose pivot - or die */
	if (fabsf(r3[1]) > fabsf(r2[1]))
		SWAP_ROWS_FLOAT(r3, r2);
	if (fabsf(r2[1]) > fabsf(r1[1]))
		SWAP_ROWS_FLOAT(r2, r1);
	if (0.0 == r1[1])
		return 0;
	/* eliminate second variable */
	m2 = r2[1] / r1[1];
	m3 = r3[1] / r1[1];
	r2[2] -= m2 * r1[2];
	r3[2] -= m3 * r1[2];
	r2[3] -= m2 * r1[3];
	r3[3] -= m3 * r1[3];
	s = r1[4];
	if (0.0 != s) {
		r2[4] -= m2 * s;
		r3[4] -= m3 * s;
	}
	s = r1[5];
	if (0.0 != s) {
		r2[5] -= m2 * s;
		r3[5] -= m3 * s;
	}
	s = r1[6];
	if (0.0 != s) {
		r2[6] -= m2 * s;
		r3[6] -= m3 * s;
	}
	s = r1[7];
	if (0.0 != s) {
		r2[7] -= m2 * s;
		r3[7] -= m3 * s;
	}
	/* choose pivot - or die */
	if (fabsf(r3[2]) > fabsf(r2[2]))
		SWAP_ROWS_FLOAT(r3, r2);
	if (0.0 == r2[2])
		return 0;
	/* eliminate third variable */
	m3 = r3[2] / r2[2];
	r3[3] -= m3 * r2[3], r3[4] -= m3 * r2[4],
	r3[5] -= m3 * r2[5], r3[6] -= m3 * r2[6], r3[7] -= m3 * r2[7];
	/* last check */
	if (0.0 == r3[3])
		return 0;
	s = 1.0 / r3[3];		/* now back substitute row 3 */
	r3[4] *= s;
	r3[5] *= s;
	r3[6] *= s;
	r3[7] *= s;
	m2 = r2[3];			/* now back substitute row 2 */
	s = 1.0 / r2[2];
	r2[4] = s * (r2[4] - r3[4] * m2), r2[5] = s * (r2[5] - r3[5] * m2),
	r2[6] = s * (r2[6] - r3[6] * m2), r2[7] = s * (r2[7] - r3[7] * m2);
	m1 = r1[3];
	r1[4] -= r3[4] * m1, r1[5] -= r3[5] * m1,
	r1[6] -= r3[6] * m1, r1[7] -= r3[7] * m1;
	m0 = r0[3];
	r0[4] -= r3[4] * m0, r0[5] -= r3[5] * m0,
	r0[6] -= r3[6] * m0, r0[7] -= r3[7] * m0;
	m1 = r1[2];			/* now back substitute row 1 */
	s = 1.0 / r1[1];
	r1[4] = s * (r1[4] - r2[4] * m1), r1[5] = s * (r1[5] - r2[5] * m1),
	r1[6] = s * (r1[6] - r2[6] * m1), r1[7] = s * (r1[7] - r2[7] * m1);
	m0 = r0[2];
	r0[4] -= r2[4] * m0, r0[5] -= r2[5] * m0,
	r0[6] -= r2[6] * m0, r0[7] -= r2[7] * m0;
	m0 = r0[1];			/* now back substitute row 0 */
	s = 1.0 / r0[0];
	r0[4] = s * (r0[4] - r1[4] * m0), r0[5] = s * (r0[5] - r1[5] * m0),
	r0[6] = s * (r0[6] - r1[6] * m0), r0[7] = s * (r0[7] - r1[7] * m0);
	MAT(outm, 0, 0) = r0[4];
	MAT(outm, 0, 1) = r0[5], MAT(outm, 0, 2) = r0[6];
	MAT(outm, 0, 3) = r0[7], MAT(outm, 1, 0) = r1[4];
	MAT(outm, 1, 1) = r1[5], MAT(outm, 1, 2) = r1[6];
	MAT(outm, 1, 3) = r1[7], MAT(outm, 2, 0) = r2[4];
	MAT(outm, 2, 1) = r2[5], MAT(outm, 2, 2) = r2[6];
	MAT(outm, 2, 3) = r2[7], MAT(outm, 3, 0) = r3[4];
	MAT(outm, 3, 1) = r3[5], MAT(outm, 3, 2) = r3[6];
	MAT(outm, 3, 3) = r3[7];
	return 1;
}
