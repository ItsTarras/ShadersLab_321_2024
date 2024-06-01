/* In Task 3, you will be modifying this vertex/fragment
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
Shader "Assignment3/Task3/PropertiesColourFragmentShader"
{
    // No properties for this shader
    Properties
    {
        _Color0 ("Color 0", Color) = (0, 0, 1, 1)
        _Height0 ("Height 0", float) = 0.1

        /*******
         * TODO: Sub task 2 Code goes here (5/6)
         *******/
         _Color1 ("Color 1", Color) = (1, 0.92, 0.016, 1) // Yellow
         _Height1 ("Height 1", float) = 0.2
         _Color2 ("Color 2", Color) = (0, 1, 0, 1)
         _Height2 ("Height 2", float) = 0.6
         _Color3 ("Color 3", Color) = (0.5, 0.5, 0.5, 1)
         _Height3 ("Height 3", float) = 0.9
        _Color4("Color 4", Color) = (1, 1, 1, 1)
        _Height4 ("Height 4", float) = 1

        /*******
         * TODO: Sub task 2 Code goes here (2/6)
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

            //Subtask 2 - 4/6
            fixed4 _Color0;
            fixed4 _Color1;
            fixed4 _Color2;
            fixed4 _Color3;
            fixed4 _Color4;
            float _Height0;
            float _Height1;
            float _Height2;
            float _Height3;
            float _Height4;

            

            /*******
             * TODO: Sub task 2 Code goes here (1/6)
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

                // Copy the vertex colour through
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

                fixed fragmentHeight = i.objectSpacePosition.y / vScale;
                /*******
                 * TODO:  Sub task 2 Code goes here (3/6)
                 *******/

                // sample the texture
                if (fragmentHeight < _Height0)
                    return _Color0; // Blue
                else if (fragmentHeight < _Height1)
                    return _Color1; // Yellow
                else if (fragmentHeight < _Height2)
                    return _Color2; // Green
                else if (fragmentHeight < _Height3)
                    return _Color3; // Gray
                else 
                    return fixed4(1, 1, 1, 1); // White

                /*******
                 * TODO: Sub task 2 Code goes here (6/6)
                 *******/

            }

            // The end of our shader code
            ENDCG
        }
    }
}