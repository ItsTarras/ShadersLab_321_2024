using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/* This class generates a mesh of a defined size and resolution using triangles
 *
 * This is the solution, which shows how to calculate the vertex positions, as
 * well as how to calculate the vertex indicies for the triangles
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2021, University of Canterbury
 * Written by Adrian Clark
 */

public class TriangleMeshSolution : MonoBehaviour
{
    // Defines the resolution of the mesh (number of vertices in width and length)
    public int meshWidth = 100;
    public int meshLength = 100;

    // Defines the material to use
    public Material materialToUse;

    // Start is called before the first frame update
    void Start()
    {
        // Create a list to store our vertices
        List<Vector3> vertices = new List<Vector3>();

        // Create a list to store our triangles
        List<int> triangles = new List<int>();

        // Create a list to store our UVs
        List<Vector2> uvs = new List<Vector2>();

        // Generate our Vertices
        // Loop through the meshes length and width
        for (int z = 0; z < meshLength; z++)
        {
            for (int x = 0; x < meshWidth; x++)
            {
                // Create a new vertex using the x and z positions
                // and the y position set to 0
                vertices.Add(new Vector3(x - (meshWidth/2), 0, z - (meshLength / 2)));

                // The UV coordinates are normalized, so we can just divide
                // the current x and z position by the width and height of the
                // mesh
                uvs.Add(new Vector2((float)x / (float)meshWidth, (float)z / (float)meshLength));
            }
        }

        // Generate our triangle Indicies
        // Loop through the meshes length-1 and width-1
        for (int z = 0; z < meshLength - 1; z++)
        {
            for (int x = 0; x < meshWidth - 1; x++)
            {
                // Multiply the Z value by the mesh width to get the number
                // of pixels in the rows, then add the value of x to get the
                // final index. Increase the values of X and Z accordingly
                // to get the neighbouring indicies
                int vTL = z * meshWidth + x;
                int vTR = z * meshWidth + x + 1;
                int vBR = (z + 1) * meshWidth + x + 1;
                int vBL = (z + 1) * meshWidth + x;

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

        // Assign the vertices and triangle indicies
        mesh.vertices = vertices.ToArray();
        mesh.triangles = triangles.ToArray();
        mesh.uv = uvs.ToArray();

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
