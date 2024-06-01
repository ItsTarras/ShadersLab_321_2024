/* In Task 3 Subtask 1, you will be modifying this vertex/fragment
 * shader to colour vertices in a height map based on
 * the height values at each vertex, given hard coded values
 *
 * The places you should write the various pieces of code
 * for the subtasks are highlighted with comments.
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

// The name of our shader
Shader "Assignment3/Task3/HardcodedColourFragmentShader"
{
    // A list of properties which will show in the Unity inspector
    // for this shader
    Properties
    {
        /*******
         * TODO: Sub task 1 Code goes here (2/3)
         *******/
         vScale ("Vertical Scale", Range(20, 40)) = 30
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
                // The vertex's position in object/model space, tagged with
                // the POSITION semantic
                float3 objectSpacePosition : POSITION;
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

                // We will store the vertex/fragment position in
                // object space in this variable. In order for our
                // position to transfer from vertex shader to fragment shader
                // it must be semantically tagged, since we are not using
                // vertex colours in our fragment shader, let's using the COLOR
                // semantic
                fixed4 objectSpacePosition : COLOR;
            };

            /*******
             * TODO: Sub task 1 Code goes here (1/3)
             *******/
             float vScale;
            
            // The function which stores our vertex shader
            // It receives a VertexIn struct in variable v
            // and returns a VertexOutFragmentIn struct
            VertexOutFragmentIn vert (VertexIn v)
            {
                // Create our VertexOutFragmentIn return variable o
                VertexOutFragmentIn o;

                // Get the input vertex's object space position 
                float3 objectSpaceVertexPosition = v.objectSpacePosition;

                // Copy the object space vertex position into the VertexOutFragmentIn
                // struct. Since this is a fixed4 variable (and our position is only
                // a fixed3) we'll swizzle the last element from the R index again
                o.objectSpacePosition = objectSpaceVertexPosition.rgbr;

                // Convert our object space vertex position to homogeneous clip space
                // using the UnityObjectToClipPos function, and store the value in our
                // output structure's clipSpacePosition member
                o.clipSpacePosition = UnityObjectToClipPos(objectSpaceVertexPosition);

                // Return the VertexOutFragmentIn variable o
                return o;
            }

            // The function which stores our fragment shader
            // It receives a VertexOutFragmentIn struct in variable i
            // and returns a fixed4 colour semantically tagged with SV_Target
            // This is the colour that will be written into the frame buffer
            fixed4 frag (VertexOutFragmentIn i) : SV_Target
            {

                fixed fragmentHeight = 0;

                /*******
                 * TODO: Sub task 1 Code goes here (3/3)
                 *******/
                 fragmentHeight = i.objectSpacePosition.y / vScale;


                // sample the texture
                if (fragmentHeight < .1f)
                    return fixed4(0, 0, 1, 1); // Blue
                else if (fragmentHeight < .2f)
                    return fixed4(1, 0.92, 0.016, 1); // Yellow
                else if (fragmentHeight < .6f)
                    return fixed4(0, 1, 0, 1); // Green
                else if (fragmentHeight < .9f)
                    return fixed4(0.5, 0.5, 0.5, 1); // Gray
                else 
                    return fixed4(1, 1, 1, 1); // White
            }

            // The end of our shader code
            ENDCG
        }
    }
}