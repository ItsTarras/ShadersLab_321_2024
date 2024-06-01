/* This shader just implements standard vertex colour shading
 * in an unlit vertex/fragment shader
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2021, University of Canterbury
 * Written by Adrian Clark
 */

// The name of our shader
Shader "Assignment3/Task3/VertexColourFragmentShader"
{
    // No properties for this shader
    Properties
    {}


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
                // The vertex's position in object/model space, tagged with
                // the POSITION semantic
                float3 objectSpacePosition : POSITION;

                // The vertex's colour
                fixed4 colour : COLOR;
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

                // The vertex/fragment colour
                fixed4 colour : COLOR;
            };

            // The function which stores our vertex shader
            // It receives a VertexIn struct in variable v
            // and returns a VertexOutFragmentIn struct
            VertexOutFragmentIn vert (VertexIn v)
            {
                // Create our VertexOutFragmentIn return variable o
                VertexOutFragmentIn o;

                // Get the input vertex's object space position 
                float3 objectSpaceVertexPosition = v.objectSpacePosition;

                // Convert our object space vertex position to homogeneous clip space
                // using the UnityObjectToClipPos function, and store the value in our
                // output structure's clipSpacePosition member
                o.clipSpacePosition = UnityObjectToClipPos(objectSpaceVertexPosition);

                // Copy the vertex colour through
                o.colour = v.colour;

                // Return the VertexOutFragmentIn variable o
                return o;
            }


            // The function which stores our fragment shader
            // It receives a VertexOutFragmentIn struct in variable i
            // and returns a fixed4 colour semantically tagged with SV_Target
            // This is the colour that will be written into the frame buffer
            fixed4 frag (VertexOutFragmentIn i) : SV_Target
            {
                // Set the colour to the interpolated fragment colour
                fixed4 colour = i.colour;

                // Return the colour variable
                return colour;
            }

            // The end of our shader code
            ENDCG
        }
    }
}