using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/* This class generates a mesh using a height map texture. The texture defines
 * the size of the mesh, and also the height of each vertex in the mesh. We also
 * define vertex colours for the mesh based on the height map, to colour the mesh
 *
 * This is the solution, which shows how to calculate the mesh size, vertex 
 * positions, vertex colours, as well as how to calculate the vertex indicies 
 * for the triangles
 * 
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2021, University of Canterbury
 * Written by Adrian Clark
 */

public class VertexColouredHeightMapMeshSolution : MonoBehaviour
{
    // Defines the height map texture used to create the mesh and set the heights
    public Texture2D heightMapTexture;

    // Defines the height scale that we multiply the height of each vertex by
    public float heightScale = 30;

    // Defines the material to use
    public Material materialToUse;

    // Start is called before the first frame update
    void Start()
    {
        // Create a list to store our vertices
        List<Vector3> vertices = new List<Vector3>();

        // Create a list to store our triangles
        List<int> triangles = new List<int>();

        // Create a list to store our vertex colours
        List<Color> vertexColours = new List<Color>();

        // Calculate the Height and Width of our mesh from the heightmap's
        // height and width 
        int height = heightMapTexture.height;
        int width = heightMapTexture.width;

        // Generate our Vertices
        // Loop through the meshes length and width
        for (int z = 0; z < height; z++)
        {
            for (int x = 0; x < width; x++)
            {
                // Create a new vertex using the x and z positions. Get the
                // y position as the pixel from the height map texture and
                // store in in yVal for use for vertex position and colouring
                // As the height map is in gray scale, we can use any colour
                // channel, in this case red.

                // Multiply the pixel value by the height scale to get the final
                // y value
                float yVal = heightMapTexture.GetPixel(x, z).r;
                vertices.Add(new Vector3(x - (width / 2), yVal * heightScale, z - (height / 2)));

                // Measure the value of yVal, and add a vertex colour accordingly

                // yVal < .1, add blue
                if (yVal < .1f)
                    vertexColours.Add(Color.blue);

                // .1 < yVal < .2, add yellow
                else if (yVal < .2f)
                    vertexColours.Add(Color.yellow);

                // .2 < yVal < .6, add green
                else if (yVal < .6f)
                    vertexColours.Add(Color.green);

                // .6 < yVal < .9, add gray
                else if (yVal < .9f)
                    vertexColours.Add(Color.gray);

                // .9 < yVal, add white
                else
                    vertexColours.Add(Color.white);
            }
        }

        // Generate our triangle Indicies
        // Loop through the meshes length-1 and width-1
        for (int z = 0; z < height - 1; z++)
        {
            for (int x = 0; x < width - 1; x++)
            {
                // Multiply the Z value by the mesh width to get the number
                // of pixels in the rows, then add the value of x to get the
                // final index. Increase the values of X and Z accordingly
                // to get the neighbouring indicies
                int vTL = z * width + x;
                int vTR = z * width + x + 1;
                int vBR = (z + 1) * width + x + 1;
                int vBL = (z + 1) * width + x;

                // Create the two triangles which make each element in the quad
                // Triangle Top Left->Bottom Left->Bottom Right
                triangles.Add(vTL);
                triangles.Add(vBL);
                triangles.Add(vBR);

                // Triangle Top Left->Bottom Right->Top Right
                triangles.Add(vTL);
                triangles.Add(vBR);
                triangles.Add(vTR);
            }
        }

        // Create our mesh object
        Mesh mesh = new Mesh();

        // Assign the vertices, triangle indicies and vertex colours to the mesh
        mesh.vertices = vertices.ToArray();
        mesh.triangles = triangles.ToArray();
        mesh.colors = vertexColours.ToArray();

        // Use recalculate normals to calculate the vertex normals for our mesh
        mesh.RecalculateNormals();

        // Create a new mesh filter, and assign the mesh from before to it
        MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
        meshFilter.mesh = mesh;

        // Create a new renderer for our mesh, and use the materialToUse
        MeshRenderer meshRenderer = gameObject.AddComponent<MeshRenderer>();
        meshRenderer.material = materialToUse;

    }
}
