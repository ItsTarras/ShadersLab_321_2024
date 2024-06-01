/* In Task 2, you will be modifying this vertex/fragment
 * shader to support height maps at a shader level.
 *
 * The places you should write the various pieces of code
 * for the subtasks are highlighted with comments.
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

// The name of our shader
Shader "Assignment3/Task2/HeightMapVertexShader"
{
     // A list of properties which will show in the Unity inspector
    // for this shader
    Properties
    {
        // The texture to use for both the Heightmap
        // AND the diffuse texture
        _MainTex ("Texture", 2D) = "white" {}

        /*******
         * TODO: Sub task 1 Code goes here (2/3)
         *******/
         heightScale ("Height Scale", float) = 30
    }

    // The code for this shader
    SubShader
    {
        // We will only use one shader pass
        Pass
        {
            // Start of our shader code
            CGPROGRAM

            // This shader has a vertex shader stored in the function vert
            #pragma vertex vert
            // And a fragment shader stored in the function frag
            #pragma fragment frag

            // Include UnityCG.cginc so we can access it's functions and variables
            #include "UnityCG.cginc"

            // This structure will store the raw vertices which go
            // into our vertex shader. 
            struct VertexIn
            {
                // To start with, we just have the vertex's position
                // in object/model space, tagged with the POSITION semantic
                float3 objectSpacePosition : POSITION;

                // The raw vertex UV coordinates
                float2 uv : TEXCOORD0;
            };

            // This structure will store the processed vertex data from
            // our vertex shader, which is then passed into our fragment shader
            // In the vertex shader, these will be "per vertex" attributes, in
            // the fragment shader, these will be interpolated "per fragment" attributes
            struct VertexOutFragmentIn
            {
                // The position of the vertex/fragment in homogeneous clip space
                // tagged with the SV_POSITION semantic
                float4 clipSpacePosition : SV_POSITION;

                // The transformed UV coordinates for this vertex/fragment
                float2 uv : TEXCOORD0;
            };

            // The texture sampler and scale transform
            // for our Main Texture
            sampler2D _MainTex;
            float4 _MainTex_ST;

            /*******
             * TODO: Sub task 1 Code goes here (1/3)
             *******/
             float heightScale;

            // The function which stores our vertex shader
            // It receives a VertexIn struct in variable v
            // and returns a VertexOutFragmentIn struct
            VertexOutFragmentIn vert (VertexIn v)
            {
                // Create our VertexOutFragmentIn return variable o
                VertexOutFragmentIn o;

                // Get the input vertex's object space position 
                float3 objectSpaceVertexPosition = v.objectSpacePosition;

                // Get the colour of the vertex from the texture map
                fixed4 vertexTextureColour = tex2Dlod(_MainTex, float4(v.uv.x, v.uv.y, 0, 0));

                /*******
                 * TODO: Sub task 1 Code goes here (3/3)
                 *******/
                objectSpaceVertexPosition.y += vertexTextureColour.r * heightScale;

                // Convert our object space vertex position to homogeneous clip space
                // using the UnityObjectToClipPos function, and store the value in our
                // output structure's clipSpacePosition member
                o.clipSpacePosition = UnityObjectToClipPos(objectSpaceVertexPosition);

                // Transform our UV coordinates based on the MainTexture Scaling Transform
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                // Return the VertexOutFragmentIn variable o
                return o;
            }

            // The function which stores our fragment shader
            // It receives a VertexOutFragmentIn struct in variable i
            // and returns a fixed4 colour semantically tagged with SV_Target
            // This is the colour that will be written into the frame buffer
            fixed4 frag (VertexOutFragmentIn i) : SV_Target
            {
                // Sample the texture based on the UV coordinates
                // stored in our VertexOutFragmentIn struct
                fixed4 colour = tex2D(_MainTex, i.uv);

                // Return the colour variable
                return colour;
            }

            // The end of our shader code
            ENDCG
        }
    }
}
